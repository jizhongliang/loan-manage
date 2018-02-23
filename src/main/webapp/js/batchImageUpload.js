var BatchImageUpload=function(){
	var self=this;
	this.attachid;
	this.columnSize=3;
	this.basepath;
	this.url_upload;
	this.url_remove;
	this.id_file;
	this.id_queue;
	this.id_batch_upload_table;
	this.id_batch_shift;
	this.id_batch_review;
	this.id_batch_remove;
	this.enable=true;
	this.pathfield="url";
	this.height=180;
	this.width=180;
	this.queryData;
	this.imagepaths=new Array();
	this.tmpIndex;	
	this.onAfterUpload;
	this.onAfterRemove;
	var timestamp=new Date().valueOf();
	
	this.getImagePaths=function(){
		return self.imagepaths;
	}
	
	var createRow=function(tableid,column_size){
		var html="<tr>";
		for(var i=0;i<column_size;i++){
			html+="<td align='center' ></td>"
		}
		html+="</tr>";
		$("#"+tableid).append(html);
		tr=$("#"+tableid+" tr:last-child")[0];
		return $(tr).children()[0];
	}
		
	var createImagePreview=function(td,imgIndex,url){
    	$(td).attr({
			width:self.width+"px",
			height:self.height+"px",
			style:"background-image:url('"+url+"'); background-size:100% 100%;border:1px solid #E2DCDC",
			valign:"bottom",
			id:"batch_image_"+imgIndex
		});
		$(td).html("<table width='"+self.width+"'  border='0' style='background-color:#E0D7D7; filter:alpha(opacity=70); -moz-opacity:0.7; -khtml-opacity: 0.7; opacity: 0.7;'></table>");
		var table=$(td).children()[0];
		var tbody = $('<tbody></tbody>'); 
		var tr=$("<tr height='32px'></tr>");
		$(tbody).append(tr);
		var td=$("<td align='left'><img name='"+self.id_batch_shift+"' index='"+imgIndex+"' src='"+self.basepath+"images/arrowLeft.png' width='32px' height='32px' title='移动' onmouseover=\"$(this).css('cursor','hand');\" onmouseout=\"$(this).css('cursor','pointer');\"/></td>");
		$(tr).append(td);
		td=$("<td align='center'><img href='"+url+"' name='"+self.id_batch_review+"' src='"+self.basepath+"images/search.png' width='32px' height='32px' title='放大' href='"+url+"' onmouseover=\"$(this).css('cursor','hand');\" onmouseout=\"$(this).css('cursor','pointer');\"/></td>");
		$(tr).append(td);
		td=$("<td align='right'><img name='"+self.id_batch_remove+"' index='"+imgIndex+"' src='"+self.basepath+"images/remove.png' width='32px' height='32px' title='删除' onmouseover=\"$(this).css('cursor','hand');\" onmouseout=\"$(this).css('cursor','pointer');\"/></td>");
		$(tr).append(td);
		$(table).append(tbody.html());
		$(td).html($(table).html());
	}
	
	var rebuildTable=function(){
		var tr=null;
		$("#"+self.attachid).html("");
		var currentIndex=0;
		do{
			if(currentIndex>=self.imagepaths.length){
				break;
			}
			var html="<tr>";
			for(var i=0;i<self.columnSize+1;i++){
				html+="<td></td>";
				currentIndex++;
			}
			html+="</tr>";
			$("#"+self.attachid).append(html);
		}while(true);
		var tds=$("#"+self.attachid+" td");
		for(var i=0;i<self.imagepaths.length;i++){
			var td=tds[i];
			var imagepath=self.imagepaths[i].url;
			createImagePreview(td,i,imagepath);
		}
		initReview();
	}
	
	var initReview=function(){
		$("[name='"+self.id_batch_review+"']").magnificPopup({
			type: 'image',
			closeOnContentClick: true,
			closeBtnInside: false,
			fixedContentPos: true,
			mainClass: 'mfp-no-margins mfp-with-zoom',
			image: {
				verticalFit: true
			},
			zoom: {
				enabled: true,
				duration: 300
			}
		});
		
		$("[name='"+self.id_batch_shift+"']").click(function(){
			if(self.imagepaths.length==0){
				return;
			}
			var index=$(this).attr("index");
			FsUtils.arrayForward(self.imagepaths, parseInt(index));
			rebuildTable();
		});
		
		$("[name='"+self.id_batch_remove+"']").click(function(){
			if(self.imagepaths.length==0){
				return;
			}
			var data=null;
			if(FsUtils.isEmpty(self.queryData)){
				data=jQuery.extend(true, {},self.queryData);
			}else{
				data={};
			}
			var index=$(this).attr("index");
			self.tmpIndex=index;
			data.index=index;
			data.imagepath=self.imagepaths[index];
			if(FsUtils.isEmpty(self.url_remove)){
				FsUtils.arrayRemove(self.imagepaths, parseInt(self.tmpIndex));
    			rebuildTable();
			}else{
				$.ajax({
		            url:self.url_remove,
		            data:data,
		            type:'post',
		            success:function(data){
		            	if(FsUtils.isEmpty(data)){
		            		return;
		            	}
		            	if(typeof data=='string'){
		 	        	   data=jQuery.parseJSON(data);
		 	            }
		            	if(!FsUtils.isEmpty(self.onAfterRemove)){
		 	        	   var ret=self.onAfterRemove(self.imagepaths,data);
		 	        	   if(!FsUtils.isEmpty(ret)&&ret){
		 	        		   rebuildTable();
		 	        	   }
		 	           }else{
		 	        	  if(data.success){
			            		FsUtils.arrayRemove(self.imagepaths, parseInt(self.tmpIndex));
			        			rebuildTable();
			            	}
		 	           }
		            }
		        });
			}
			
		});
	}
	
	this.getRealpaths=function(){
		var realpaths=new Array();
		for(var i=0;i<self.imagepaths.length;i++){
			var imagepath=self.imagepaths[i];
			realpaths.push(imagepath);
		}
		return realpaths;
	}
	
	this.setRealpaths=function(realpaths){
		self.imagepaths=new Array();
		if(FsUtils.isEmpty(realpaths)||realpaths.length==0){
			return;
		}
		for(var i=0;i<realpaths.length;i++){
			var realpath=realpaths[i];
			self.imagepaths.push(
					{url:realpath}
			);
		}
		rebuildTable();
	}
	
	this.init=function(opts){
		if(FsUtils.isEmpty(opts.attachid,
				opts.basepath,opts.url_upload)){
			console.log("参数错误");
			return;
		}
		
		self.attachid=opts.attachid;
		self.basepath=opts.basepath;
		self.url_upload=opts.url_upload;
		
		if(!FsUtils.isEmpty(opts.enable)){
			self.enable=opts.enable;
		}
		
		if(!FsUtils.isEmpty(opts.columnSize)){
			self.columnSize=opts.columnSize;
		}
		
		if(!FsUtils.isEmpty(opts.queryData)){
			self.queryData=opts.queryData;
		}
		
		if(!FsUtils.isEmpty(opts.imagepaths)){
			self.imagepaths=opts.imagepaths;
		}
		
		if(!FsUtils.isEmpty(opts.url_remove)){
			self.url_remove=opts.url_remove;
		}
		
		if(!FsUtils.isEmpty(opts.onAfterUpload)){
			self.onAfterUpload=opts.onAfterUpload;
		}
		
		if(!FsUtils.isEmpty(opts.onAfterRemove)){
			self.onAfterRemove=opts.onAfterRemove;
		}
		
		if(FsUtils.isEmpty(self.id_file,self.id_queue)){
			self.id_file="batch_upload"+timestamp;
			self.id_queue="batch_queue"+timestamp;
			if(self.enable){
				self.id_batch_upload_table="batch_upload_table"+timestamp;
				$("#"+self.attachid).parent().prepend("<table id='"+self.id_batch_upload_table+"' width='100%'></table>");
				var html="<tr><td width='120px'><input id='"+self.id_file+"' name='"+self.id_file+"' type='file'></td>";
				html+="<td colspan='"+(self.columnSize-1)+"' id='"+self.id_queue+"'></td></tr>";
				$("#"+self.id_batch_upload_table+"").html(html);
			}
		}
		
		self.id_batch_shift="batch_shift"+timestamp;
		self.id_batch_review="batch_review"+timestamp;
		self.id_batch_remove="batch_remove"+timestamp;
		
		$(self.attachid).attr({
			"cellspacing":"10",
			"height":self.height+"px"
		});
		
		if(FsUtils.isEmpty(self.queryData)){
			self.queryData={"position":self.imagepaths.length};
		}else{
			self.queryData.position=self.imagepaths.length;
		}
		
		$('#'+self.id_file).uploadify({
			'queueID'  : this.id_queue,
			'swf'      : this.basepath+'uploadify/uploadify.swf',
			'multi':true,
			'formData':self.queryData,
			'uploader' : self.url_upload,
			'progressData' : 'percentage',
			'buttonText' :'点击选择图片',
			'onUploadStart' : function(file) {
				layer_load(0,"请等待上传..");
				var fds=$("#"+self.id_file).uploadify("settings", "formData");
				fds.position=self.imagepaths.length;
				$("#"+self.id_file).uploadify("settings", "formData", fds);
			},
           'onUploadError' : function(file, str, code,code_error) {
        	   if(code==503){
        		   layer.msg(file.name+"尺寸不符合");
        	   }
        	   layer.closeAll('loading');
	       },
			'onUploadSuccess' : function(file, data, response) {
			   layer.closeAll('loading');
	           if(FsUtils.isEmpty(data)){
	        	   return;
	           }
	           if(typeof data=='string'){
	        	   data=jQuery.parseJSON(data);
	           }
	           if(!FsUtils.isEmpty(self.onAfterUpload)){
	        	   var ret=self.onAfterUpload(self.imagepaths,data);
	        	   if(!FsUtils.isEmpty(ret)&&ret){
	        		   rebuildTable();
	        	   }
	           }else{
	        	   if(data["success"]){
		        	   self.imagepaths.push({url:data[self.pathfield]});
					   rebuildTable();
		           }
	           }
	           
	        }
		});
		
		if(self.imagepaths.length>0){
			rebuildTable();
		}
	}
	
	if(arguments!=null&&arguments.length>0){
		self.init(arguments[0]);
	}
}