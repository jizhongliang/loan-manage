<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/common/common.jspf"%>
    <script src="${path}/common/plugins/jquery.dataTables.min.js"></script>
    <script src="${path}/common/plugins/jquery.dataTables.bootstrap.js "></script>

    <style>
        body{font-size: 12px; line-height: 1.5em; background-color: #f2f2f2; }
        .layui-table th {
            font-weight: bold;
        }
        .layui-table td, .layui-table th{
            padding: 16px 8px;
            word-break: break-all;
        }
        .layui-table tbody tr:hover, .layui-table-hover{
            background-color: #eaf8fe!important;
        }
        .layui-table[lay-skin=line] {
            border: 0px solid #e2e2e2;
        }
        .layui-table[lay-skin=line] tr {
            border-radius: 6px 6px 0 0;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div class="hwc-inner">
                <div class="app-init-container">
                    <div class="search-list">
                        <form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
                            <input type="hidden" id="id" value="${id}"/>
                            <p class="mb20 pl10">
                                <label class="f-12" style="margin-left: 24px">借款金额：</label>
                                <input type="text" class="input-sm" id="amount" name="amount" readonly/>
                                <label class="f-12 ml15">借款日利率(%)：</label>
                                <input type="text" class="input-sm" id="rate" name="rate" readonly/>
                                <label class="f-12"  style="margin-left: 27px">分期数：</label>
                                <input type="text" class="input-sm" id="periods" name="periods" readonly/>
                                <label class="f-12"  style="margin-left: 27px">总利息：</label>
                                <input type="text" class="input-sm" id="interest" name="interest" readonly/>
                            </p>
                            <p class="mb20 pl10">
                                <label class="f-12"  style="margin-left: 12px">还款总金额：</label>
                                <input type="text" class="input-sm" id="total_amount" name="total_amount" readonly/>
                                <label class="f-12" style="margin-left: 47px">已还期数：</label>
                                <input type="text" class="input-sm" id="hasRepay_periods" name="hasRepay_periods" readonly/>
                                <label class="f-12 ml15">未还期数：</label>
                                <input type="text" class="input-sm" id="unRepay_periods" name="unRepay_periods" readonly/>
                                <label class="f-12 ml15">未还金额：</label>
                                <input type="text" class="input-sm" id="unRepay_amount" name="unRepay_amount" readonly/>
                            </p>
                            <p class="mb20 pl10">
                                <label class="f-12">首次还款日期：</label>
                                <input type="text" class="input-normal" id="first_repay_date" name="first_repay_date" readonly/>
                                <label class="f-12 ml15">最后一次还款时间：</label>
                                <input type="text" class="input-normal" id="end_repay_date" name="end_repay_date" readonly/>
                                <label class="f-12 ml15">还款银行卡号：</label>
                                <input type="text" class="input-normal" id="bankCardNo" name="bankCardNo" readonly/>
                            </p>
                        </form>
                    </div>
                    <div style="clear: both"></div>
                </div>
                <div style="position: relative; border-radius: 6px 6px 0 0;">
                    <div class="h-table-processing" id="processing" style="display: none;"></div>
                    <div>
                        <table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
                            <thead class="h-table-head">
                            <tr>
                                <th>还款金额(元)</th>
                                <th>应还本金(元)</th>
                                <th>应还利息(元)</th>
                                <th>逾期天数</th>
                                <th>逾期金额(元)</th>
                                <th>实际还款(元)</th>
                                <th>剩余本金(元)</th>
                                <th>还款日期</th>
                                <th>还款期数</th>
                                <th>还款状态</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function () {
        var id = $("#id").val();
        $.ajax({
            type: "POST",
            data:{id:id},
            url:"${path}/repayMana/repaymentDetail.shtml",
            async: false,
            error: function(request) {
                parent.layer.msg("网络异常，操作失败");
                restore_Btn_submit(ele);
            },
            success: function(ret) {
                if(ret.success==true){
//                    console.log(ret);
                    var data = ret.data;
                    var plans = data.plans;
                    if (!FsUtils.isEmpty(data)){
                        allPrpos(data);
                    }

                    var searchtable =  $('#table_list').dataTable({
                        "bSort":false,
                        "searching": false,
                        "bLengthChange": false,
                        "iDisplayLength":10,
                        "data": plans,
                        "columns": [
                            { "data": "amount","sClass":"txt-cen" },
                            { "data": "realAmount","sClass":"txt-cen" },
                            { "data": "interest","sClass":"txt-cen" },
                            { "data": "penaltyDay","sClass":"txt-cen" },
                            { "data": "penaltyAmout","sClass":"txt-cen" },
                            { "data": "repayAmount","sClass":"txt-cen" },
                            { "data": "realAmountBalance","sClass":"txt-cen" },
                            { "data": "repayDate","sClass":"maxWidth" },
                            { "data": "seq","sClass":"txt-cen" },
                            { "data": "state" }
                        ],
                        "aoColumnDefs": [
                            {
                                sDefaultContent: '',
                                aTargets: [ '_all' ]
                            }
                        ],
                        "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                            var d=new Date(aData.repayDate)
                            var date = formatDate(d)
                            $('td:eq(7)', nRow).html(date);
                            if(aData.state == "10"){
                                $('td:eq(9)', nRow).html('已还款');
                            }else if(aData.state == "20"){
                                $('td:eq(9)', nRow).html('<span class="font-red">未还款</span>');
                            }
                        },
                        'language': {
                            'search': ''
                        }
                    });

                }else{
                    parent.layer.msg("操作失败! "+ret.message);
                    restore_Btn_submit(ele);
                }
            }
        });
    });

    function  formatDate(now){
        var year=now.getFullYear();
        var month=now.getMonth()+1;
        var date=now.getDate();
        var hour=now.getHours();
        var minute=now.getMinutes();
        var second=now.getSeconds();
        return year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
    }

    function allPrpos(obj,type) {
        // 用来保存所有的属性名称和值
        var props = "";
        // 开始遍历
        for(var p in obj){
            // 方法
            if(typeof(obj[p])=="function"){
                obj[p]();
            }else{
                var _value = obj[p];
                $("#"+p).val(_value);
            }
        }
    }
</script>

</body>
</html>