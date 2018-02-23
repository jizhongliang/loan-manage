package com.lm.utils;

import java.util.List;

public class ListPagination {

    public static List subList(List list, int currentPage, int maxNum, int pageNum) {
        int fromIndex = 0;
        int toIndex = 0;
        if (list == null || list.size() == 0)
            return null;
        // 当前页小于或等于总页数时执行
        if (currentPage <= pageNum && currentPage != 0) {
            fromIndex = (currentPage - 1) * maxNum;
            if (currentPage == pageNum) {
                toIndex = list.size();
            } else {
                toIndex = currentPage * maxNum;
            }
        }
        return list.subList(fromIndex, toIndex);
    }
}
