package com.dockter.semver.java;

/**
 * A class specifically for capturing build information. This information comes
 * from the pom.xml.
 */
public final class BuildInfo {

	private static final String VERSION = "${project.version}";
	private static final String GROUPID = "${project.groupId}";
	private static final String ARTIFACTID = "${project.artifactId}";
	private static final String TIMESTAMP = "${timestamp}";

	private static final String GIT_BRANCH = "${git.branch}";
	private static final String GIT_REPOSITORY_NAME = "${git.repository.name}";
	private static final String GIT_SHA = "${git.sha}";

	public static String getVersion() {
		return VERSION;
	}

	public static String getTimestamp() {
		return TIMESTAMP;
	}

	public static String getGitBranch() {
		return GIT_BRANCH;
	}

	public static String getGitSHA() {
		return GIT_SHA;
	}

}
