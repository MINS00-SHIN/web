package com.team2.healthsns.mapper;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;

import java.util.List;

public interface CommunityMapper_qa {
    public int communityInsertQa(CommunityVO vo);
    public List<CommunityVO> communityPageListQa(PagingVO pVO);
    public int totalRecordQa(PagingVO pVO);
    public CommunityVO communitySelectQa(int post_id);
    //조회수 증가
    public void hitCountQa(int post_id);
    //게시판 수정
    public int communityUpdateQa(CommunityVO vo);
    //게시글 삭제
    public int communityDeleteQa(int post_id);
}
