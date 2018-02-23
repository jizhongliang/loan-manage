var dialogdatas;
$(function() {
   
});
//编辑商品分组对话框
var editCat = function(cid) {
    $('#showProductCat').modal({
        show: true,
        remote: '/productCat/getProductCatById.shtml?cid='+cid
    });
}

