package com.dockter.semver.java;

/**
 * A class specifically for capturing build information. This information comes
 * from the pom.xml.
 */
public final class BuildInfo {

	private static final String GIT_BRANCH = "${git.branch}";
	private static final String GIT_REPOSITORY_NAME = "${git.repository.name}";
	private static final String GIT_SHA = "${git.sha}";
	private static final String GIT_VERSION_LONG = "${git.version.long}";

	private static final String MAVEN_ARTIFACTID = "${project.artifactId}";
	private static final String MAVEN_GROUPID = "${project.groupId}";
	private static final String MAVEN_TIMESTAMP = "${timestamp}";
	private static final String MAVEN_VERSION = "${project.version}";

	public static String getGitBranch() {
		return GIT_BRANCH;
	}

	public static String getGitSHA() {
		return GIT_SHA;
	}

	public static String getGitVersionLong() {
		return GIT_VERSION_LONG;
	}

	public static String getMavenTimestamp() {
		return MAVEN_TIMESTAMP;
	}

	public static String getMavenVersion() {
		return MAVEN_VERSION;
	}
}
