package com.dockter.semver.java;

/**
 * Hello world!
 */
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World! version 0.0.0");
		System.out.println("Code version: 0.0.3");
		System.out.println("Git  version: " + BuildInfo.getVersion());
	}
}
