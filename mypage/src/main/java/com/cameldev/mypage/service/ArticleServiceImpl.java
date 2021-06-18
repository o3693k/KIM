package com.cameldev.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cameldev.mypage.commons.paging.Criteria;
import com.cameldev.mypage.commons.paging.SearchCriteria;
import com.cameldev.mypage.domain.ArticleVO;
import com.cameldev.mypage.persistence.ArticleDAO;
import com.cameldev.mypage.persistence.ArticleFileDAO;

@Service
public class ArticleServiceImpl implements ArticleService {

	private final ArticleDAO articleDAO;
	private final ArticleFileDAO articleFileDAO;

	@Inject
	public ArticleServiceImpl(ArticleDAO articleDAO, ArticleFileDAO articleFileDAO) {
		this.articleDAO = articleDAO;
		this.articleFileDAO = articleFileDAO;
	}

	@Transactional
	@Override
	public void create(ArticleVO articleVO) throws Exception {
		String[] files = articleVO.getFiles();

		if (files == null) {
			articleDAO.create(articleVO);
			articleDAO.updateWriterImg(articleVO);
			return;
		}
		articleVO.setFileCnt(files.length);

		articleDAO.create(articleVO);
		articleDAO.updateWriterImg(articleVO);
		Integer article_no = articleVO.getArticle_no();
		for (String fileName : files) {
			articleFileDAO.addAttach(fileName, article_no);
		}
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public ArticleVO read(Integer article_no) throws Exception {
		articleDAO.updateViewCnt(article_no);
		return articleDAO.read(article_no);
	}

	@Transactional
	@Override
	public void update(ArticleVO articleVO) throws Exception {
		int article_no = articleVO.getArticle_no();
		articleFileDAO.deleteAllAttach(article_no);

		String[] files = articleVO.getFiles();
		if (files == null) {
			articleVO.setFileCnt(0);
			articleDAO.update(articleVO);
			return;
		}

		articleVO.setFileCnt(files.length);
		articleDAO.update(articleVO);
		for (String fileName : files) {
			articleFileDAO.replaceAttach(fileName, article_no);
		}
	}

	@Transactional
	@Override
	public void delete(Integer article_no) throws Exception {
		articleFileDAO.deleteAllAttach(article_no);
		articleDAO.delete(article_no);
	}

	@Override
	public List<ArticleVO> listAll() throws Exception {
		return articleDAO.listAll();
	}

	@Override
	public List<ArticleVO> listCriteria(Criteria criteria) throws Exception {
		return articleDAO.listCriteria(criteria);
	}

	@Override
	public int countArticles(Criteria criteria) throws Exception {
		return articleDAO.countArticles(criteria);
	}

	@Override
	public List<ArticleVO> listSearch(SearchCriteria searchCriteria) throws Exception {
		return articleDAO.listSearch(searchCriteria);
	}

	@Override
	public int countSearchedArticles(SearchCriteria searchCriteria) throws Exception {
		return articleDAO.countSearchedArticles(searchCriteria);
	}

	@Override
	public List<ArticleVO> userBoardList(String uid) throws Exception {
		return articleDAO.userBoardList(uid);
	}

}
