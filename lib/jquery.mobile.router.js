/*!
 * jQueryMobile-router v0.93
 * http://github.com/azicchetti/jquerymobile-router
 *
 * Copyright 2011 (c) Andrea Zicchetti
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://github.com/azicchetti/jquerymobile-router/blob/master/MIT-LICENSE.txt
 * http://github.com/azicchetti/jquerymobile-router/blob/master/GPL-LICENSE.txt
 */
(function(a,b){if(typeof define==="function"&&define.amd){define(["jquery"],b)}else{b(jQuery)}}(this,function(a){a(document).bind("mobileinit",function(){var e=a.extend({fixFirstPageDataUrl:false,firstPageDataUrl:"index.html",ajaxApp:false,firstMatchOnly:false},a.mobile.jqmRouter||{});var c=true;function b(h){if(c){console.log(h)}}var f=null,g=null,d=false;a(document).bind("pagebeforechange",function(l,k){var i=(typeof k.toPage==="string")?k.toPage:k.toPage.jqmData("url")||"";if(k.options.hasOwnProperty("_jqmrouter_handled")){return}k.options._jqmrouter_handled=true;if(k.options.data&&(k.options.type+"").toLowerCase()=="get"){i+="?"+k.options.data}var h=a.mobile.path.parseUrl(i);f=g;g=h;if(h.hash.indexOf("?")!==-1||(h.hash.length>0&&f!==null&&f.hash.indexOf(h.hash+"?")!==-1)){var j=h.hash.replace(/\?.*$/,"");k.options.dataUrl=h.href;if(a.mobile.activePage&&j.replace(/^#/,"")==a.mobile.activePage.jqmData("url")){k.options.allowSamePageTransition=true&&!d;a.mobile.changePage(a(j),k.options)}else{a.mobile.changePage(a(j),k.options)}l.preventDefault();a.mobile.urlHistory.ignoreNextHashChange=true}d=false;if(window.location.hash.indexOf("&ui-state=dialog")!=-1){d=true}});if(e.fixFirstPageDataUrl){a(document).ready(function(){if(!window.location.pathname.match("/$")){return}var i=a(":jqmData(role='page')").first();var j=i.jqmData("url"),h=window.location.pathname+e.firstPageDataUrl+window.location.search+window.location.hash;if(j!=h){i.attr("data-url",h).jqmData("url",h)}})}a.mobile.Router=function(l,j,k){this.routes={pagebeforecreate:null,pagecreate:null,pagebeforeshow:null,pageshow:null,pagebeforehide:null,pagehide:null,pageinit:null,pageremove:null,pagebeforechange:null,pagebeforeload:null,pageload:null,popupbeforeposition:null,popupafteropen:null,popupafterclose:null};this.evtLookup={bC:"pagebeforechange",bl:"pagebeforeload",l:"pageload",bc:"pagebeforecreate",c:"pagecreate",bs:"pagebeforeshow",s:"pageshow",bh:"pagebeforehide",h:"pagehide",i:"pageinit",rm:"pageremove",pbp:"popupbeforeposition",pao:"popupafteropen",pac:"popupafterclose"};this.routesRex={};this.conf=a.extend({},e,k||{});this.defaultHandlerEvents={};if(this.conf.defaultHandlerEvents){var h=this.conf.defaultHandlerEvents.split(",");for(var m=0;m<h.length;m++){this.defaultHandlerEvents[this.evtLookup[h[m]]]=h[m]}}this.add(l,j)};a.extend(a.mobile.Router.prototype,{documentEvts:{pagebeforechange:1,pagebeforeload:1,pageload:1},add:function(k,j,m){if(!k){return}var h=this,i=[],n=[];if(k instanceof Array){a.each(k,a.proxy(function(p,o){this.add(o,j,true)},this))}else{a.each(k,function(t,q){if(typeof(q)=="string"||typeof(q)=="function"){if(h.routes.pagebeforeshow===null){h.routes.pagebeforeshow={}}h.routes.pagebeforeshow[t]=q;if(!h.routesRex.hasOwnProperty(t)){h.routesRex[t]=new RegExp(t)}}else{var p,s=q.events.split(","),o;for(p=0;p<s.length;p++){o=h.evtLookup[s[p]];if(h.routes.hasOwnProperty(o)){if(h.routes[o]===null){h.routes[o]={}}h.routes[o][t]=q.handler;if(!h.routesRex.hasOwnProperty(t)){h.routesRex[t]=new RegExp(t)}}else{b("can't set unsupported route "+s[p])}}}})}if(m===true){return}if(!this.userHandlers){this.userHandlers=j||{}}else{a.extend(this.userHandlers,j||{})}a.each(h.routes,function(o,p){if(p!==null){if(!h.documentEvts[o]){i.push(o)}else{n.push(o)}}});this._detachEvents();var l=function(p,o){h._processRoutes(p,o,this)};if(i.length>0){this._eventData={events:i.join(" "),selectors:":jqmData(role='page'),:jqmData(role='dialog')",handler:l};a(document).delegate(this._eventData.selectors,this._eventData.events,this._eventData.handler)}if(n.length>0){this._docEventData={events:n.join(" "),handler:l};a(document).bind(this._docEventData.events,this._docEventData.handler)}},_processRoutes:function(m,q,n){var o=this,p,i,l,h=0;if(m.type in {pagebeforehide:true,pagehide:true,pageremove:true}){p=f}else{p=g}do{if(!p){if(n){l=a(n);p=l.jqmData("url");if(p){if(l.attr("id")==p){p="#"+p}p=a.mobile.path.parseUrl(p)}}}else{if(!this.documentEvts[m.type]&&n&&!a(n).jqmData("url")){return}}if(!p){return}i=(!this.conf.ajaxApp?p.hash:p.pathname+p.search+p.hash);if(i.length==0){p=""}h++}while(i.length==0&&h<=1);var k=false;a.each(this.routes[m.type],function(r,t){var s,v;if((s=i.match(o.routesRex[r]))){if(typeof(t)=="function"){v=t}else{if(typeof(o.userHandlers[t])=="function"){v=o.userHandlers[t]}}if(v){try{v.apply(o.userHandlers,[m.type,s,q,n,m]);k=true}catch(u){b(u)}}}if(k&&o.conf.firstMatchOnly){return false}});if(!k&&this.conf.defaultHandler&&this.defaultHandlerEvents[m.type]){if(typeof(this.conf.defaultHandler)=="function"){try{this.conf.defaultHandler.apply(o.userHandlers,[m.type,q,n,m])}catch(j){b(j)}}}},_detachEvents:function(){if(this._eventData){a(document).undelegate(this._eventData.selectors,this._eventData.events,this._eventData.handler)}if(this._docEventData){a(document).unbind(this._docEventData.events,this._docEventData.handler)}},destroy:function(){this._detachEvents();this.routes=this.routesRex=null},getParams:function(h){if(!h){return null}var k={},i;var j=h.slice(h.indexOf("?")+1).split("&");a.each(j,function(m,l){i=l.split("=");i[0]=decodeURIComponent(i[0]);if(k[i[0]]){if(!(k[i[0]] instanceof Array)){k[i[0]]=[k[i[0]]]}k[i[0]].push(decodeURIComponent(i[1]))}else{k[i[0]]=decodeURIComponent(i[1])}});if(a.isEmptyObject(k)){return null}return k}})});return{}}));