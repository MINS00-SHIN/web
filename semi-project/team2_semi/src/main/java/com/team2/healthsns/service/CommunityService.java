package com.team2.healthsns.service;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommunityService {
    public int CommunityInsertAuth(CommunityVO vo);
    public List<CommunityVO> CommunityPageListAuth(PagingVO pVO);
    public int totalRecordAuth(PagingVO pVO);
    public CommunityVO CommunitySelectAuth(int post_id);
    public void hitCountAuth(int post_id);
    public int CommunityUpdateAuth(CommunityVO vo);
    public int CommunityDeleteAuth(int post_id);

    public int CommunityInsertFree(CommunityVO vo);
    public List<CommunityVO> CommunityPageListFree(PagingVO pVO);
    public int totalRecordFree(PagingVO pVO);
    public CommunityVO CommunitySelectFree(int post_id);
    public void hitCountFree(int post_id);
    public int CommunityUpdateFree(CommunityVO vo);
    public int CommunityDeleteFree(int post_id);

    public int CommunityInsertQa(CommunityVO vo);
    public List<CommunityVO> CommunityPageListQa(PagingVO pVO);
    public int totalRecordQa(PagingVO pVO);
    public CommunityVO CommunitySelectQa(int post_id);
    public void hitCountQa(int post_id);
    public int CommunityUpdateQa(CommunityVO vo);
    public int CommunityDeleteQa(int post_id);
    public void increaseLike(int post_id);
}
