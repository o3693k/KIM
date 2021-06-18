package com.cameldev.mypage.service;

import java.util.List;

public interface ArticleFileService {

	List<String> getAttach(Integer article_no) throws Exception;

	void deleteAttach(String fileName) throws Exception;

	void updateAttachCnt(Integer article_no) throws Exception;

}
