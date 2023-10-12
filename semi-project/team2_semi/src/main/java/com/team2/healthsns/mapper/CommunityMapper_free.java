package com.team2.healthsns.mapper;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;

import java.util.List;

public interface CommunityMapper_free {
    public int communityInsertFree(CommunityVO vo);
    public List<CommunityVO> communityPageListFree(PagingVO pVO);
    public int totalRecordFree(PagingVO pVO);
    public CommunityVO communitySelectFree(int post_id);
    //조회수 증가
    public void hitCountFree(int post_id);
    //게시판 수정
    public int communityUpdateFree(CommunityVO vo);
    //게시글 삭제
    public int communityDeleteFree(int post_id);
}
