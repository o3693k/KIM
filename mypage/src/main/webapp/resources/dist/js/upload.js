function getFileInfo(fullName){
	var fileName;
	var imgsrc;
	var getLink;
	
	var fileLink;
	
	if(checkImageType(fullName)){
		imgsrc = "/mypage/file/display?fileName="+fullName;
		fileLink = fullName.substr(14);
		var front = fullName.substr(0, 12);
		var end = fullName.substr(14);
		getLink = "/mypage/file/display?fileName=" + front+end;
	}else{
		imgsrc = "/mypage/resources/upload/files/file-icon.png";
		fileLink = "/mypage/file/display?fileName="+fullName;
	}
	
	fileName = fileLink.substr(fileLink.indexOf("_")+1);
	
	return {fileName: fileName, imgsrc: imgsrc, getLink: getLink, fullName: fullName};
	
}
function checkImageType(fileName){
	var pattern =  /jpg$|gif$|png$|jpge$/i;
	return fileName.match(pattern);
}
