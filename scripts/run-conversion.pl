:- module(dmd_run,
	  [ run_all/0
	  ]).

user:file_search_path(data,       'C:/Users/vdboer/git/dmd/scripts').

:- use_module(library(semweb/rdf_db)).

:- rdf_register_prefix(dmd,	   'http://purl.org/collections/nl/dss/dmd/',[force(true)]).
:- rdf_register_prefix(dssprefix,	   'http://purl.org/collections/nl/dss/mdb/aanmonstering-dokkun_w-',[force(true)]). % these need to be reset for each archive
:- rdf_register_prefix(githubprefix,  'https://raw.githubusercontent.com/biktorrr/dmd/master/dongeradeel/',[force(true)]).

:- use_module([ library(xmlrdf/xmlrdf),
		library(semweb/rdf_cache),
		library(semweb/rdf_library),
		library(semweb/rdf_turtle_write)
	      ]).
:- use_module(dmd_rewrite).

:- initialization			% run *after* loading this file
	rdf_set_cache_options([ global_directory('cache/rdf'),
				create_global_directory(true)
			      ]).

load_dongeradeel:-
        absolute_file_name(data('fotolijst_dongeradeel.xml'), File,
			   [ access(read)
			   ]),
	load(File).

load(File) :-
	rdf_current_ns(dmd, Prefix),
	load_xml_as_rdf(File,
			[ dialect(xml),
			  unit(record),
			  prefix(Prefix),
			  graph(data)
			]).


run_all:-
	load_dongeradeel,
	rewrite,
	save_dong.

save_dong:-
	absolute_file_name(data('dongeradeel.ttl'), File,
			   [ access(write)
			   ]),
	rdf_save_turtle(File,[graph(data)]).











