:- module(dmd_rewrite,
	  [ rewrite/0,
	    rewrite/1,
	    rewrite/2,
	    list_rules/0
	  ]).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(xmlrdf/rdf_convert_util)).
:- use_module(library(xmlrdf/cvt_vocabulary)).
:- use_module(library(xmlrdf/rdf_rewrite)).

:- debug(rdf_rewrite).

%%	rewrite
%
%	Apply all rules on the graph =data=

rewrite :-
	rdf_rewrite(data).

%%	rewrite(+Rule)
%
%	Apply the given rule on the graph =data=

rewrite(Rule) :-
	rdf_rewrite(data, Rule).

%%	rewrite(+Graph, +Rule)
%
%	Apply the given rule on the given graph.

rewrite(Graph, Rule) :-
	rdf_rewrite(Graph, Rule).

%%	list_rules
%
%	List the available rules to the console.

list_rules :-
	rdf_rewrite_rules.

:- discontiguous
	rdf_mapping_rule/5.





record_to_Images @@
{S, rdf:type, dmd:'Record'}
<=>
{S, rdf:type, dmd:'Image'}.


add_uri @@
{S, rdf:type, dmd:'Image'},
{S, dmd:fotonummer, literal(L)}\
{S}
<=>
literal_to_id([L],dmd,URI),
	{URI}.

link_to_image @@
{S, dmd:fotonummer, literal(L)}
==>
literal_to_id([L,'.jpg'], githubprefix, URI),
% change this for archive
	{S, dmd:source, URI}.


linkenAan @@
{S, dmd:linkenAan, literal(L)}
==>
literal_to_id([L], dssprefix, URI),
% change this for archive
	{S, dmd:depicts, URI}.

clean @@
{_,_,""}
<=>
true.











