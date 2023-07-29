opts = spreadsheetImportOptions("NumVariables", 17);
opts.Sheet = "sc36210";
opts.DataRange = "A2:Q97";
opts.VariableNames = ["LiftCoefficientData", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
cl_data = readtable("sc36210.xls", opts, "UseExcel", false);
clear opts
opts = spreadsheetImportOptions("NumVariables", 17);
opts.Sheet = "sc36210";
opts.DataRange = "A101:Q196";
opts.VariableNames = ["LiftCoefficientData", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
cd_data = readtable("sc36210.xls", opts, "UseExcel", false);
clear opts
