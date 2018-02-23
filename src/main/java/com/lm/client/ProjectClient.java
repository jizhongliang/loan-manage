package com.lm.client;

import com.hwc.base.sdk.core.Client;
import com.hwc.base.sdk.core.ClientConfig;
import com.hwc.base.sdk.core.RequestBase;
import com.hwc.base.sdk.core.ResponseBase;
import com.lm.common.ProjectConstant;
import com.lm.utils.SessionUtils;

import javax.servlet.http.HttpSession;

public class ProjectClient {

    private static ProjectClient projectClient = null;

    public static ProjectClient getInstance() {
        if (projectClient == null) {
            projectClient = new ProjectClient();
        }
        return projectClient;
    }

    public static <T extends ResponseBase> T getResult(RequestBase<T> request) throws Exception{
        ClientConfig clientConfig = new ClientConfig();
        clientConfig.setHost(ProjectConstant.URL_ROOT);
        clientConfig.setConnectTimeout(ProjectConstant.TIME_OUT);
        clientConfig.setSocketTimeout(ProjectConstant.TIME_OUT);
        // 如果token存在
        HttpSession session = SessionUtils.getSession();
        if(session != null) {
            String token = (String) session.getAttribute("token");
            clientConfig.setToken(token);
        }
        Client client = new Client(clientConfig);
        return client.invoke(request);
    }

}
