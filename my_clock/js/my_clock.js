function httpRequest(url, callback){
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            callback(xhr.responseText);
        }
    }
    xhr.send();
}
function postData(url,data,callback){
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            callback(xhr.responseText);
        }
    }
    xhr.send(data);
}
function login(worknumber,password){
httpRequest('https://mcas.sf-express.com/cas/login', function(ip){
    document.getElementById('ip_div').innerHTML = ip;
    var ltObj = document.getElementsByTagName('lt')[0];
    if(ltObj!=undefined){
        var lt = ltObj.innerHTML;
        document.getElementById('lt_div').innerText = "正在登录...";
        data = "lt="+lt+"&username="+worknumber+"&password="+password+"&additional="+worknumber+"|"+password+"&_eventId=submit&submit=submit";
        postData("https://mcas.sf-express.com/cas/login",data,function(resdata){
            document.getElementById('lt_div').innerHTML = resdata;
        });
    }
});
}
function checkIsLoginSuccess(){
    httpRequest('https://mcas.sf-express.com/cas/login', function(ip){
        //如果有登录成功字样，说明其已经登录成功
        var ip_div = document.getElementById('ip_div');
        var status_show = document.getElementById('lt_div');
        ip_div.innerHTML = ip;
        var successH2 = ip_div.getElementsByTagName('h2');
        console.log(successH2);
        if(!successH2[0]){
            status_show.innerText = "未登录";
            return false;
        }
        if (ip_div.getElementsByTagName('h2')[0].innerText=='登录成功') {
            status_show.innerText = "已经登录成功";
            return true;
        }else{
            status_show.innerText = "未登录";
            return false;
        }

    });
}
checkIsLoginSuccess();
var loginButton = document.getElementById("loginButton");
loginButton.onclick = function(){
    var worknumber  = document.getElementById("workNumber").value;
    var password    = document.getElementById("passWord").value;
    login(worknumber,password);
}