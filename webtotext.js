void((function(){
    function get(n){return document.querySelectorAll(n);};
    function rm(n){get(n).forEach(function(e){e.parentNode.removeChild(e)});};

    rm('SCRIPT');
    rm('STYLE');
    rm('IMG');
    rm('IFRAME');
    rm('CANVAS');
    rm('SVG');
    rm('FORM');
    rm('HR');
    rm('META');
    rm('FIGURE');
    rm('VIDEO');

    get('*').forEach(function(e){
        var s=e.style;
        s.color="black";
        s.background="white none no-repeat fixed center";
        s.border="0px none white";
        s["border-image"]="";
        s["box-shadow"]="0px 0px white";
        e.removeAttribute("class");
    });
})())

void((function(){
    function rme(n){
        function cp(n,c=0){return n?cp(n.parentElement,c+1):c;};
        var all=Array.apply(null,get('*'));
        all.sort((x,y)=>cp(y)-cp(x));
        all.forEach((e)=>{if(e.childNodes.length==0){e.parentNode.removeChild(e);console.log(e);}});
    };
    
    rme('P');
    rme('DIV');
)())