package android

// Global config used by Cosmic soong additions
var CosmicConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.cosmic.hardware",
	},
}
