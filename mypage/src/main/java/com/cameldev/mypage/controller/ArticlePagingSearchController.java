package com.cameldev.mypage.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cameldev.mypage.commons.paging.PageMaker;
import com.cameldev.mypage.commons.paging.SearchCriteria;
import com.cameldev.mypage.domain.ArticleVO;
import com.cameldev.mypage.service.ArticleService;

@Controller
@RequestMapping("/article/paging/search")
public class ArticlePagingSearchController {

	private static final Logger logger = LoggerFactory.getLogger(ArticlePagingSearchController.class);

	private final ArticleService articleService;

	@Inject
	public ArticlePagingSearchController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String writeGET() {
		logger.info("search writeGET() called...");

		return "article/search/write";
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writePOST(ArticleVO articleVO, RedirectAttributes redirectAttributes) throws Exception {
		logger.info("search writePOST() called...");

		articleService.create(articleVO);
		redirectAttributes.addFlashAttribute("msg", "regSuccess");

		return "redirect:/article/paging/search/list";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception {

		logger.info("search lsit() called...");

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(articleService.countSearchedArticles(searchCriteria));

		model.addAttribute("articles", articleService.listSearch(searchCriteria));
		model.addAttribute("pageMaker", pageMaker);

		return "/article/search/list";
	}

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(@RequestParam("article_no") int article_no, @ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model)
			throws Exception {
		logger.info("search read() called...");
		model.addAttribute("article", articleService.read(article_no));

		return "/article/search/read";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyGET(@RequestParam("article_no") int article_no, @ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model)
			throws Exception {
		logger.info("search modifyGet() called...");
		logger.info(searchCriteria.toString());
		model.addAttribute("article", articleService.read(article_no));

		return "/article/search/modify";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(ArticleVO ariArticleVO, SearchCriteria searchCriteria, RedirectAttributes redirectAttributes) throws Exception {
		logger.info("search modifyPOST called...");
		articleService.update(ariArticleVO);
		redirectAttributes.addAttribute("page", searchCriteria.getPage());
		redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
		redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
		redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());
		redirectAttributes.addAttribute("msg", "modSuccess");

		return "redirect:/article/paging/search/list";
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("article_no") int article_no, SearchCriteria searchCriteria, RedirectAttributes redirectAttributes)
			throws Exception {
		logger.info("search remove() called...");
		articleService.delete(article_no);
		redirectAttributes.addAttribute("page", searchCriteria.getPage());
		redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
		redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
		redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());
		redirectAttributes.addAttribute("msg", "delSuccess");

		return "redirect:/article/search/list";
	}
}
