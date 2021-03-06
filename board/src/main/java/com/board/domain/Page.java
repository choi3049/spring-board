package com.board.domain;

public class Page {

	public void setNum(int num) {
		this.num = num;
	}

	public void setCount(int count) {
		this.count = count;

		dataCalc();
	}

	public int getNum() {
		return num;
	}

	public int getCount() {
		return count;
	}

	public int getPostNum() {
		return postNum;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getDisplayPost() {
		return displayPost;
	}

	public int getPageNumCnt() {
		return pageNumCnt;
	}

	public int getFirstPageNum() {
		return firstPageNum;
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public boolean getPrev() {
		return prev;
	}

	public boolean getNext() {
		return next;
	}

	// 현재 페이지 번호
	private int num;

	// 게시물 총 갯수
	private int count;

	// 한 페이지에 출력할 게시물 갯수
	private int postNum = 5;

	// 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
	private int pageNum;

	// 출력할 게시물
	private int displayPost;

	// 한번에 표시할 페이징 번호의 갯수
	private int pageNumCnt = 10;

	// 1페이지
	private int firstPageNum = 1;

	// 표시되는 페이지 번호 중 마지막 번호
	private int endPageNum;

	// 표시되는 페이지 번호 중 첫번째 번호
	private int startPageNum;

	// 다음/이전 표시 여부
	private boolean prev;
	private boolean next;

	private void dataCalc() {

		// 하단 페이징 번호
		pageNum = (int) Math.ceil((double) count / postNum);

		// 마지막 번호
		endPageNum = (int) (Math.ceil((double) num / (double) pageNumCnt) * pageNumCnt);

		// 시작 번호
		startPageNum = endPageNum - (pageNumCnt - 1);

		// 마지막 번호 재계산
		int endPageNum_tmp = pageNum;

		if (endPageNum > endPageNum_tmp) {
			endPageNum = endPageNum_tmp;
		}

		prev = num == 1 ? false : true;
		next = num == endPageNum_tmp ? false : true;

		displayPost = (num - 1) * postNum;

	}

	// 검색 타입과 검색어
	public String getSearchTypeKeyword() {
		 
		 if((searchType.equals(searchType) && keyword.equals(keyword)) && (fromDate != null || toDate != null)) {
		 return "&searchType=" + searchType + "&keyword=" + keyword + "&fromDate=" + fromDate + "&toDate=" + toDate; 
		 } else if((searchType.equals(searchType) || keyword.equals(keyword)) && (fromDate == null || toDate == null)){
		  return "&searchType=" + searchType + "&keyword=" + keyword; 
		 } else if((searchType.equals("") || keyword.equals("")) && (fromDate != null || toDate != null)) {	
		  return "&fromDate=" + fromDate + "&toDate=" + toDate;
		 } else {
		  return ""; 
		 }
		}

		private String searchType;
		private String keyword; 

		public void setSearchType(String searchType) {
		 this.searchType = searchType;  
		}

		public String getSearchType() {
		 return searchType;
		} 

		public void setKeyword(String keyword) {
		 this.keyword = keyword;  
		} 

		public String getKeyword() {
		 return keyword;
		}
		
		private String fromDate;
		private String toDate; 
		
		public String getFromDate() {
			return fromDate;
		}

		public void setFromDate(String fromDate) {
			this.fromDate = fromDate;
		}

		public String getToDate() {
			return toDate;
		}

		public void setToDate(String toDate) {
			this.toDate = toDate;
		}


}
