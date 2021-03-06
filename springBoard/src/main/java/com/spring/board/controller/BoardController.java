package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		int page = 1;
		int totalCnt = 0;
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		CommonUtil commonUtil = new CommonUtil();
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		codeList = boardService.selectCodeList();
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(codeList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);

		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/boardSeach.do", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String boardSeach(Locale locale,PageVo pageVo) throws Exception{
		
		int page = 1;
		int totalCnt = 0;
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		CommonUtil commonUtil = new CommonUtil();
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		codeList = boardService.selectCodeList();
		// ?????? ???? ???????? ???? ?? ?????? ????
		boardList = boardService.SearchBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo.getCodeList());
		result.put("codeList", codeList);
		result.put("boardList", boardList);
		result.put("totalCnt", totalCnt);
		result.put("pageNo", page);
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		//System.out.println("callbackMsg : "+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		codeList = boardService.selectCodeList();
		
		model.addAttribute("codeList", codeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		// vo?????? list<vo>?????????? get,set ??????.
		// json???? ??????, list<vo>[index].boardTitle ???? ???????? ?????? vo?? ?????????? list?? ??.
		List<BoardVo> blist = boardVo.getBoardVolist();
		System.out.println(blist);
		
		
		
		int cnt = 1;
		for(BoardVo b : blist){
			
			int resultCnt = boardService.boardInsert(b);
			
			if(resultCnt <= 0) {
				//?????? insert ???????? break???? ????...
				result.put("success","N");
				break;
			} else if (cnt == blist.size()) {
				result.put("success", "Y");
			}
			cnt ++;
			
		}
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;

	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		// ???? ???????? ????
		// ???? ???? ?????? ???? ???? ?????????? view?? ???? boardType, boardNum???? DB?? ??????.
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo) throws Exception{
		
		//???? ????. DB ???????? 
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale, BoardVo boardVo) throws Exception{
		
		//???? ????. DB ???????? 
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);		
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
}
