package com.dockter.semver.java;

/**
 * Hello world!
 */
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("");
		System.out.println("Hello World!");
		System.out.println("Code version: 0.0.11");
		System.out.println("Git  version: " + BuildInfo.getMavenVersion());
		System.out.println("");
		System.out.println("Git SHA: " + BuildInfo.getGitSHA());
		System.out.println("Git long version: " + BuildInfo.getGitVersionLong());
		System.out.println("Build date: " + BuildInfo.getMavenTimestamp());
		System.out.println("");
	}
}
