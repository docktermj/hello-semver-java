package com.dockter.semver.java;

/**
 * A class specifically for capturing build information. This information comes
 * from the pom.xml.
 */
public final class BuildInfo {

	private static final String VERSION = "${project.version}";
	private static final String GROUPID = "${project.groupId}";
	private static final String ARTIFACTID = "${project.artifactId}";
	private static final String REVISION = "${buildNumber}";

	public static String getVersion() {
		return VERSION;
	}
}
