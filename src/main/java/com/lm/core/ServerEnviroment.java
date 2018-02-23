package com.lm.core;


import org.springframework.stereotype.Service;

import cn.freesoft.FsParameters;

@Service
public class ServerEnviroment {
	private FsParameters parameters;

	public FsParameters getParameters() {
		return parameters;
	}

	public void setParameters(FsParameters parameters) {
		this.parameters = parameters;
	}
}
