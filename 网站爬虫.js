//将储存的字符串
sessionStorage.getItem('numbers').split(',').length

//Version 1.0 
sessionStorage.removeItem('page');
sessionStorage.removeItem('numbers');

function foo() {
    var page = Number(sessionStorage.getItem('page') || 1);
    var arr = sessionStorage.getItem('numbers') ? sessionStorage.getItem('numbers').split(',') : [];
    location.href = 'http://www.lajidianhua.com/list-8-177201-{0}.html'.replace('{0}', page);
    Array.from(document.querySelectorAll('.listbox table td b a')).forEach((ele, index) => {
        // console.info(ele.innerText); 
        arr.push(ele.innerText);
    });
    sessionStorage.setItem('numbers', arr);
    sessionStorage.setItem('page', ++page);
    page <= 800 && foo();
}
foo();

//Verson 1.1 增加100秒延迟加载
sessionStorage.removeItem('page');
sessionStorage.removeItem('numbers');

function foo() {
    var page = Number(sessionStorage.getItem('page') || 1);
    var arr = sessionStorage.getItem('numbers') ? sessionStorage.getItem('numbers').split(',') : [];
    location.href = 'http://www.lajidianhua.com/list-8-177201-{0}.html'.replace('{0}', page);
    Array.from(document.querySelectorAll('.listbox table td b a')).forEach((ele, index) => {
        // console.info(ele.innerText);
        arr.push(ele.innerText);
    });
    sessionStorage.setItem('numbers', arr);
    sessionStorage.setItem('page', ++page);
    setTimeout(function() {
        page <= 7000 && foo();
    }, 100);
}

foo();

//bug 获取的号码都是第一页的号码，25个号码循环。原因：先在第一个页面执行完所有的循环再跳转

//V2.0
//获取页面元素
function getElem() {
    var e = document.querySelectorAll('b>a');
    var arr = [];
    for (i = 0; i < e.length; i++) {
        arr.push(86 + e[i].innerText);
    }
}

//页面跳转
function pages() {
    for (ii = 1; ii < 5; ii++) {
        h = "http://www.lajidianhua.com/list-8-177198-" + ii + ".html";
        location.href = h;
        console.info(h);
    }
}
//人工循环吧，绝望
function getElem() {
    var e = document.querySelectorAll('b>a');
    var arr = [];
    for (i = 0; i < e.length; i++) {
        arr.push(e[i].innerText);
    }
}
arr.join(",86")

//找到号码库中长度为13的号码，并升序排列
var b = [];
for (var i = 0; i < arr.length; i++) {
    if (arr[i].toString().length == 13) {
        b.push(arr[i]);
        //console.info(arr[i]);
    }
}
b.sort();
b.join();