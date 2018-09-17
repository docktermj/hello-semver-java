package com.dockter.semver.java;

/**
 * Hello world!
 */
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World!");
		System.out.println("Code version: 0.0.6");
		System.out.println("Git  version: " + BuildInfo.getVersion());
	}
}
