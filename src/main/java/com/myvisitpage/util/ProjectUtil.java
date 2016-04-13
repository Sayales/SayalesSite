package com.myvisitpage.util;

import com.myvisitpage.model.ProjectChunk;

import java.util.Set;

/**
 * Created by Павел on 04.04.2016.
 */
public class ProjectUtil {
    private ProjectUtil() {
    }
    public static int totalValue(Set<ProjectChunk> chunks) {
        int res = 0;
        for (ProjectChunk chunk : chunks) {
            res += chunk.getValue();
        }
        return res;
    }
}
