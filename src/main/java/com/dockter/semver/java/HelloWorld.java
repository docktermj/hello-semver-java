package com.dockter.semver.java;

/**
 * Hello world!
 */
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("");
		System.out.println("Hello World!");
		System.out.println("Code version: 0.0.8");
		System.out.println("Git  version: " + BuildInfo.getVersion());
		System.out.println("Git      SHA: " + BuildInfo.getGitSHA());
		System.out.println("Build   date: " + BuildInfo.getTimestamp());
		System.out.println("");
	}
}
