package com.cameldev.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cameldev.mypage.persistence.ArticleFileDAO;

@Service
public class ArticleFileServiceImpl implements ArticleFileService {

	private final ArticleFileDAO articlefileDAO;

	@Inject
	public ArticleFileServiceImpl(ArticleFileDAO articlefileDAO) {
		this.articlefileDAO = articlefileDAO;
	}

	@Override
	public List<String> getAttach(Integer article_no) throws Exception {
		return articlefileDAO.getAttach(article_no);
	}

	@Override
	public void deleteAttach(String fileName) throws Exception {
		articlefileDAO.deleteAttach(fileName);
	}

	@Override
	public void updateAttachCnt(Integer article_no) throws Exception {
		articlefileDAO.updateAttachCnt(article_no);
	}

}
