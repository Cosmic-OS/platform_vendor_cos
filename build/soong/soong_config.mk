# Insert new variables inside the Cosmic structure
cosmic_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"Cosmic": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
