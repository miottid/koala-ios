#!/usr/bin/env node

var PROJECT_NAME = 'Koala';

var Localize = require('localize-with-spreadsheet');

var spreadsheet = Localize.fromGoogleSpreadsheet('1_ybVFNwVsYcsnHlXeL1J0Ls47jsMkx3aAzyP4usVOhE', '*');

spreadsheet.setKeyCol('key');

var languages = [ 'fr', 'en', 'tr', 'pt' ];

languages.forEach(function(lang){
  spreadsheet.save(PROJECT_NAME + "/" + lang + ".lproj" + "/Localizable.strings", {
    valueCol: lang, format: 'ios'
  });
});

spreadsheet.save(PROJECT_NAME + "/Base.lproj" + "/Localizable.strings", {
  valueCol: 'fr', format: 'ios'
});
