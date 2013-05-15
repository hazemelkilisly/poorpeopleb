// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require_tree .

function getElementsByClassName(classname, node)  {
    if(!node) node = document.getElementsByTagName("body")[0];
    var a = [];
    var re = new RegExp('\\b' + classname + '\\b');
    var els = node.getElementsByTagName("*");
    for(var i=0,j=els.length; i<j; i++)
        if(re.test(els[i].className))a.push(els[i]);
    return a;
}

function showhide(x) {
  var ele = document.getElementById(x);
  if (ele.style.display == "none"){
    var elements = new Array();
    elements = getElementsByClassName('collabsing');
    for(i in elements ){
         elements[i].style.display = "none";
    }
    ele.style.display = 'table-row';
  }else{
    var elements = new Array();
    elements = getElementsByClassName('collabsing');
    for(i in elements ){
         elements[i].style.display = "none";
    }
  }
}

function inst_hide(x) {
    $('#'+x).slideUp();
}

function inst_show(x) {
    $('#'+x).slideDown();
}

$(document).ready(function() { 
  jQuery('.datepicker').datepicker({format: 'dd-mm-yyyy', autoclose: true});
  jQuery('.btn').tooltip();
});
