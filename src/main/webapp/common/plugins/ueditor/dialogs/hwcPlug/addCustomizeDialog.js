var curWwwPath=window.document.location.href;   
var pathName=window.document.location.pathname;  
var pos=curWwwPath.indexOf(pathName); //获取主机地址，如： http://localhost:8083  
var localhostPaht=curWwwPath.substring(0,pos); //获取带"/"的项目名，如：/uimcardprj  
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);   
var rootPath = localhostPaht+projectName; 
UE.registerUI('dialog',function(editor,uiName){

    //创建dialog
    var dialog = new UE.ui.Dialog({
        //指定弹出层中页面的路径，这里只能支持页面,因为跟addCustomizeDialog.js相同目录，所以无需加路径
        iframeUrl:rootPath+'/ueditor/dialogs/hwcPlug/relevancyShop.jsp',
        //需要指定当前的编辑器实例
        editor:editor,
        //指定dialog的名字
        name:'relevancyShop',
        //dialog的标题
        title:"关联店铺",

        //指定dialog的外围样式
        cssRules:"width:650px; height:400px;",

        //如果给出了buttons就代表dialog有确定和取消
        buttons:[
            {
                className:'edui-okbutton',
                label:'确定',
                onclick:function () {
                    dialog.close(true);
                }
            },
            {
                className:'edui-cancelbutton',
                label:'取消',
                onclick:function () {
                    dialog.close(false);
                }
            }
        ]});

    //参考addCustomizeButton.js
    var btn = new UE.ui.Button({
        name:'关联店铺',
        title:'关联店铺',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -755px -77px;',
        onclick:function () {
            //渲染dialog
            dialog.render();
            dialog.open();
        }
    });

    return btn;
}/*index 指定添加到工具栏上的那个位置，默认时追加到最后,editorId 指定这个UI是那个编辑器实例上的，默认是页面上所有的编辑器都会添加这个按钮*/);
UE.registerUI('product',function(editor,uiName){
    //创建dialog
    var dialog = new UE.ui.Dialog({
        //指定弹出层中页面的路径，这里只能支持页面,因为跟addCustomizeDialog.js相同目录，所以无需加路径
        iframeUrl:rootPath+'/ueditor/dialogs/hwcPlug/showShopList.jsp',
        //需要指定当前的编辑器实例
        editor:editor,
        //指定dialog的名字
        name:'relevancyProduct',
        //dialog的标题
        title:"关联商品",

        //指定dialog的外围样式
        cssRules:"width:650px; height:400px;",

        //如果给出了buttons就代表dialog有确定和取消
        buttons:[
            {
                className:'edui-okbutton',
                label:'确定',
                onclick:function () {
                    dialog.close(true);
                }
            },
            {
                className:'edui-cancelbutton',
                label:'取消',
                onclick:function () {
                    dialog.close(false);
                }
            }
        ]});

    //参考addCustomizeButton.js
    var btn = new UE.ui.Button({
        name:'关联商品',
        title:'关联商品',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -786px -77px;',
        onclick:function () {
            //渲染dialog
            dialog.render();
            dialog.open();
        }
    });

    return btn;
});
UE.registerUI('tel',function(editor,uiName){
    //创建dialog
    var dialog = new UE.ui.Dialog({
        //指定弹出层中页面的路径，这里只能支持页面,因为跟addCustomizeDialog.js相同目录，所以无需加路径
        iframeUrl:rootPath+'/ueditor/dialogs/hwcPlug/tel.html',
        //需要指定当前的编辑器实例
        editor:editor,
        //指定dialog的名字
        name:'relevancyTel',
        //dialog的标题
        title:"设置拨打电话",

        //指定dialog的外围样式
        cssRules:"width:400px; height:100px;",

        //如果给出了buttons就代表dialog有确定和取消
        buttons:[
            {
                className:'edui-okbutton',
                label:'确定',
                onclick:function () {
                    dialog.close(true);
                }
            },
            {
                className:'edui-cancelbutton',
                label:'取消',
                onclick:function () {
                    dialog.close(false);
                }
            }
        ]});

    //参考addCustomizeButton.js
    var btn = new UE.ui.Button({
        name:'设置拨打电话',
        title:'设置拨打电话',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -815px -77px;',
        onclick:function () {
            //渲染dialog
            dialog.render();
            dialog.open();
        }
    });

    return btn;
});