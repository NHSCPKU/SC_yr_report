/*
***统计年报数据两个表的表头不只是首行，在导入前对三个原始EXCEL作了去掉excel首行表头处理
***********************
*/
clear all 
set more off
cd "E:\" 

*note
**2012/2014excel中没有变量“医院等级批准时间”，为了批量处理，需手动添加空白列于excel R列（在R列前需插入一列空列）
**同时删掉2012/2014excel中多出的无用A列
**注：并非在原始xlxs中更改，仅更改data/year_report/hosp下的excel

*****机构年报数据
capture prog drop medinst_dta
prog medinst_dta
	syntax, doc(str)

	clear
	import excel "data/year_report/hosp/机构年报`doc'.xlsx", allstring
	save "data/temp/hosp_year_report_`doc'.dta", replace

	*** ===============================================var label======================================================================
	use "data/temp/hosp_year_report_`doc'.dta", clear
	rename (A B C D E F G H I J K L M N O P Q) ///
		   (num hosp hospid cons_code a1 a2 a3 a4 a5 a6 a7 a8 setup level grade grade_appro grade_time)
		   
	label var num 			"序号"
	label var hosp 			"机构名称"
	label var hospid 		"机构ID"
	label var cons_code 	"组织机构代码"
	label var a1 			"经济类型代码"
	label var a2 			"卫生机构类别代码"
	label var a3 			"机构分类管理代码"
	label var a4 			"行政区划代码"
	label var a5 			"乡镇街道代码"
	label var a6 			"设置/主办单位代码"
	label var a7 			"政府办卫生机构隶属关系代码"
	label var a8 			"是否分支机构"
	label var setup 		"单位成立时间(年)"
	label var level 		"级别"
	label var grade 		"等次"
	label var grade_appro 	"医院最近一次等级评定批准文号"
	label var grade_time 	"医院等级批准时间"

	rename (R S T U V W X Y Z AA AB) ///
		   (region_cen regcen_type regcen_lev special_key spe_key1 spe_key2 spe_key3 set_key set_key1 set_key2 set_key3)
		   
	label var region_cen 	"是否区域医疗中心"
	label var regcen_type	"区域医疗中心类别"
	label var regcen_lev 	"级别"
	label var special_key 	"政府主管部门评定的临床重点专科个数"
	label var spe_key1 		"部级"
	label var spe_key2 		"省级"
	label var spe_key3 		"市级"
	label var set_key 		"年内政府投资的临床重点专科建设项目个数"
	label var set_key1 		"部级"
	label var set_key2 		"省级"
	label var set_key3 		"市级"

	rename (AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF) ///
		   (contractor contractor_act employee emp_techhealth emp_techhealth1 emp_techhealth2 emp_techhealth3 emp_techhealth4 ///
			emp_techhealth5 emp_techhealth6 emp_techhealth7 emp_techoth emp_manager emp_skiller training1 training2 training3 ///
			training4 training5 training6 beds_pre beds_actual beds_day1 beds_day2 beds_day3 equip_val equip_num equip_num1 ///
			equip_num2 equip_num3)
			
	label var contractor 		"本年编制人数"
	label var contractor_act 	"其中：在编人数"
	label var employee 			"在职职工数"
	label var emp_techhealth 	"卫生技术人员"
	label var emp_techhealth1 	"执业医师 "
	label var emp_techhealth2 	"职业助理医师"
	label var emp_techhealth3 	"注册护士"
	label var emp_techhealth4 	"药师（士）"
	label var emp_techhealth5 	"检验技师（士）"
	label var emp_techhealth6 	"影像技师（士）"
	label var emp_techhealth7 	"其他卫生技术人员"
	label var emp_techoth 		"其他技术人员"
	label var emp_manager 		"管理人员"
	label var emp_skiller 		"工勤技能人员"
	label var training1 		"参加政府举办的岗位培训人次数"
	label var training2 		"其中：领导干部参加培训人次数"
	label var training3 		"中层干部参加培训人次数"
	label var training4 		"其中：人事干部参加培训人次数"
	label var training5 		"接受继续医学教育人数"
	label var training6 		"进修半年以上人数"
	label var beds_pre 			"编制床位(张)"
	label var beds_actual 		"实有床位(张)"
	label var beds_day1 		"实际开放总床日数"
	label var beds_day2 		"实际占用总床日数"
	label var beds_day3 		"出院者占用总床日数"
	label var equip_val 		"万元以上设备总价值（万元）"
	label var equip_num 		"万元以上设备台数"
	label var equip_num1 		"其中：10-49万元设备"
	label var equip_num2 		"50-99万元设备"
	label var equip_num3 		"100万元及以上设备"

	rename (BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CA CB CC ///
			CD CE CF CG CH CI CJ CK CL CM CN CO CP CQ CR CS CT CU CV CW CX CY CZ DA DB DC DD DE)  ///
		   (inc_total inc_medical out_inc out_inc1 out_inc2 out_inc3 out_inc4 out_inc5 out_inc6 out_inc7 out_incdrug ///
			out_incdrug1 out_incdrug2 out_incdrug3 out_incdrug4 out_incch out_incoth out_incphar out_incnew in_inc ///
			in_inc1 in_inc2 in_inc3 in_inc4 in_inc5 in_inc6 in_inc7 in_inc8 in_incdrug in_incdrug1 in_incdrug2 in_incdrug3 ///
			in_incdrug4 in_incch in_incphar in_incoth in_incnew inc_basic inc_ch inc_ch1 inc_ch2 inc_ch3 inc_subsidy inc_subsidy1 ///
			inc_subsidy2 inc_subsidy3 inc_SE inc_OTH inc_OTHUWB inc_OTHURB inc_OTHNRC)
			
	label var inc_total 	"总收入"
	label var inc_medical 	"医疗收入"
	label var out_inc 		"门诊收入"
	label var out_inc1 		"挂号收入"
	label var out_inc2 		"诊察收入"
	label var out_inc3 		"检查收入"
	label var out_inc4 		"化验收入"
	label var out_inc5 		"治疗收入"
	label var out_inc6 		"手术收入"
	label var out_inc7 		"卫生材料收入"
	label var out_incdrug 	"药品收入"
	label var out_incdrug1 	"西药收入"
	label var out_incdrug2 	"中草药收入"
	label var out_incdrug3 	"中成药收入"
	label var out_incdrug4 	"院内中药制剂收入"
	label var out_incch 		"中医非药物疗法收入"
	label var out_incoth 	"药事服务费收入"
	label var out_incphar 	"其他门诊收入"
	label var out_incnew 	"新技术、新项目收入"
	label var in_inc 		"住院收入"
	label var in_inc1 		"其中：床位收入"
	label var in_inc2 		"诊察收入"
	label var in_inc3 		"检查收入"
	label var in_inc4 		"化验收入"
	label var in_inc5 		"治疗收入"
	label var in_inc6 		"手术收入"
	label var in_inc7 		"护理收入"
	label var in_inc8 		"卫生材料收入"
	label var in_incdrug 	"药品收入"
	label var in_incdrug1 	"西药收入"
	label var in_incdrug2 	"中草药收入"
	label var in_incdrug3 	"中成药收入"
	label var in_incdrug4 	"院内中药制剂收入"
	label var in_incch 		"中医非药物疗法收入"
	label var in_incphar 	"药事服务费收入"
	label var in_incoth 	"其他住院收入"
	label var in_incnew 	"新技术、新项目收入"
	label var inc_basic 	"门诊和住院药品收入中：基本药物收入"
	label var inc_ch 		"医疗收入中：中医专科收入"
	label var inc_ch1 		"其中:国家级"
	label var inc_ch2 		"省级"
	label var inc_ch3 		"市级"
	label var inc_subsidy 	"财政补助收入"
	label var inc_subsidy1 	"其中：基本支出"
	label var inc_subsidy2 	"项目支出"
	label var inc_subsidy3 	"其中：基本建设资金"
	label var inc_SE 		"科教项目收入"
	label var inc_OTH 		"其他收入"
	label var inc_OTHUWB 	"总收入中:城镇职工基本医疗保险收入"
	label var inc_OTHURB 	"城镇居民基本医疗保险收入"
	label var inc_OTHNRC 	"新型农村合作医疗补偿收入"

	rename (DF DG DH DI DJ DK DL DM DN DO DP DQ DR DS DT DU DV DW DX DY DZ) ///
		   (inc_totcost inc_totcost1 inc_totcost11 inc_totcost12 inc_totcost13 inc_totcost2 inc_totcost3 inc_totcost4 inc_totcost5 ///
			inc_othcost inc_othcost1 inc_othcost11 inc_othcost12 inc_othcost13 inc_othcost14 inc_othcost15 inc_othcost16 inc_othcost17 ///
			inc_othcost2 inc_othcost3 inc_othcost4)
			
	label var inc_totcost 	"总费用/支出"
	label var inc_totcost1 	"医疗业务成本"
	label var inc_totcost11 "其中：临床服务成本"
	label var inc_totcost12 "医疗技术成本"
	label var inc_totcost13 "医疗辅助成本"
	label var inc_totcost2 	"财政项目补助支出"
	label var inc_totcost3 	"科教项目支出"
	label var inc_totcost4 	"管理费用"
	label var inc_totcost5 	"其中：离退休费"
	label var inc_othcost 	"其他支出"
	label var inc_othcost1 	"总费用中：人员经费"
	label var inc_othcost11 "其中：基本工资"
	label var inc_othcost12 "津贴补贴"
	label var inc_othcost13 "奖金"
	label var inc_othcost14 "社会保障缴费"
	label var inc_othcost15 " 绩效工资"
	label var inc_othcost16 "内：基础性绩效工资"
	label var inc_othcost17 "奖励性绩效工资"
	label var inc_othcost2 	"卫生材料费"
	label var inc_othcost3 	"药品费"
	label var inc_othcost4 	"其中：基本药物支出"

	rename (EA EB EC ED EE) ///
		   (total_visit out_visit emer_visit in_visit discharge_num)
		   
	label var total_visit 	"总诊疗人次"
	label var out_visit 	"门诊人次"
	label var emer_visit 	"急诊人次"
	label var in_visit 		"入院人次"
	label var discharge_num "出院人次"

	***==================================================================var correction========================================================
	local vars a1 a2 a3 a6 a7 a8 level grade region_cen regcen_type regcen_lev
	foreach var of local vars{
		clonevar `var'N=`var'
	}
	*经济类型代码
	tab a1
	replace  a1 = "1"  if a1 == "内资" 
	replace  a1 = "2"  if a1 == "国有全资" 
	replace  a1 = "3"  if a1 == "集体全资" 
	replace  a1 = "4"  if a1 == "股份合作" 
	replace  a1 = "5"  if a1 == "联营" 
	replace  a1 = "6"  if a1 == "有限责任(公司)" 
	replace  a1 = "7"  if a1 == "股份有限(公司)" 
	replace  a1 = "8"  if a1 == "私有" 
	replace  a1 = "9"  if a1 == "其他内资" 
	replace  a1 = "10" if a1 == "内地和港澳台合作" 
	replace  a1 = "11" if a1 == "中外合资" | a1 == "中外合作"
	replace  a1 = "12" if a1 == "其他" 

	*卫生机构类别代码
	tab a2,m
	replace  a2 = "1"  if a2 == "中医（综合）医院" 
	replace  a2 = "2"  if a2 == "中西医结合医院" 
	replace  a2 = "3"  if a2 == "传染病医院" 
	replace  a2 = "4"  if a2 == "儿童医院" 
	replace  a2 = "5"  if a2 == "其他专科医院" 
	replace  a2 = "6"  if a2 == "其他中医专科医院" 
	replace  a2 = "7"  if a2 == "其他民族医院" 
	replace  a2 = "8"  if a2 == "口腔医院" 
	replace  a2 = "9"  if a2 == "妇产（科）医院" 
	replace  a2 = "10" if a2 == "妇幼保健院" 
	replace  a2 = "11" if a2 == "康复医院" 
	replace  a2 = "12" if a2 == "心血管病医院" 
	replace  a2 = "13" if a2 == "护理院" 
	replace  a2 = "14" if a2 == "整形外科医院" 
	replace  a2 = "15" if a2 == "疗养院" 
	replace  a2 = "16" if a2 == "皮肤病医院" 
	replace  a2 = "17" if a2 == "眼科医院" 
	replace  a2 = "18" if a2 == "精神病医院" 
	replace  a2 = "19" if a2 == "综合医院" 
	replace  a2 = "20" if a2 == "美容医院" 
	replace  a2 = "21" if a2 == "耳鼻喉科医院" 
	replace  a2 = "22" if a2 == "职业病医院" 
	replace  a2 = "23" if a2 == "肛肠医院" 
	replace  a2 = "24" if a2 == "肿瘤医院" 
	replace  a2 = "25" if a2 == "胸科医院" 
	replace  a2 = "26" if a2 == "藏医院" 
	replace  a2 = "27" if a2 == "骨伤医院" 
	replace  a2 = "28" if a2 == "骨科医院" 
	replace  a2 = "29" if a2 == "麻风病医院" 

	*机构分类管理代码
	tab a3,m
	replace  a3 = "1" if a3 == "营利性医疗机构"
	replace  a3 = "2" if a3 == "非营利性医疗机构"

	*设置/主办单位代码   
	tab a6,m
	replace  a6 = "1" if a6 == "个人"
	replace  a6 = "2" if a6 == "事业单位"
	replace  a6 = "3" if a6 == "企业"
	replace  a6 = "4" if a6 == "其他社会组织"
	replace  a6 = "5" if a6 == "其他行政部门"
	replace  a6 = "6" if a6 == "卫生行政部门"
	replace  a6 = "7" if a6 == "社会团体"

	*政府办卫生机构隶属关系代码
	tab a7,m
	replace  a7 = "1" if a7 == "中央属"
	replace  a7 = "2" if a7 == "县级市（省辖市区）属"
	replace  a7 = "3" if a7 == "县（旗）属"
	replace  a7 = "4" if a7 == "省辖市（地区、州、直辖市区）属"
	replace  a7 = "5" if a7 == "省（自治区、直辖市）属"
	replace  a7 = "6" if a7 == "镇属"
	replace  a7 = "." if a7 == ""

	*是否分支机构
	tab a8,m
	replace  a8 = "1" if a8 == "是"
	replace  a8 = "0" if a8 == "否"

	*级别 
	tab level,m
	replace level = "1" if level == "一级" 
	replace level = "2" if level == "二级" 
	replace level = "3" if level == "三级" 
	replace level = "0" if level == "未定级" 
	replace level = "." if level == ""

	*等次
	tab grade,m
	replace grade = "1" if grade == "丙等"
	replace grade = "2" if grade == "乙等"
	replace grade = "3" if grade == "甲等"
	replace grade = "0" if grade == "未定"
	replace grade = "." if grade == ""

	*是否区域医疗中心
	tab region_cen,m
	replace region_cen = "0" if region_cen == "否"
	replace region_cen = "1" if region_cen == "是"
	replace region_cen = "." if region_cen == ""

	*区域医疗中心类别
	tab regcen_type,m
	replace regcen_type = "1" if regcen_type == "专科性"
	replace regcen_type = "2" if regcen_type == "综合性"
	replace regcen_type = "." if regcen_type == ""

	*级别
	tab regcen_lev,m
	replace regcen_lev = "1" if regcen_lev == "市级"
	replace regcen_lev = "2" if regcen_lev == "省级"
	replace regcen_lev = "3" if regcen_lev == "国家"
	replace regcen_lev = "." if regcen_lev == ""

	*单位成立时间(年)
	gen year_setup  = substr(setup, 1, 4)

	*医院等级批准时间
	replace grade_time = "" if grade_time == "无"
	gen year_grade  = substr(grade_time, 1, 4)

	***================================================================value label===============================================================
	destring, replace

	label define a1 1 "内资" 2 "国有全资" 3 "集体全资" 4 "股份合作" 5 "联营" 6 "有限责任（公司）" 7 "股份有限（公司）" 8 "私有" ///
					9 "其他内资" 10 "内地和港澳台合作" 11 "中外合资" 12 "其他"
	label val  a1 a1  
			 
	label define a2 1 "中医（综合）医院" 2 "中西医结合医院" 3 "传染病医院" 4 "儿童医院" 5 "其他专科医院" 6 "其他中医专科医院" ///
					7 "其他民族医院" 8 "口腔医院" 9 "妇产（科）医院" 10 "妇幼保健院" 11 "康复医院" 12 "心血管病医院" 13 "护理院" ///
					14 "整形外科医院" 15 "疗养院" 16 "皮肤病医院" 17 "眼科医院" 18 "精神病医院" 19 "综合医院" 20 "美容医院" ///
					21 "耳鼻喉科医院" 22 "职业病医院" 23 "肛肠医院" 24 "肿瘤医院" 25 "胸科医院" 26 "藏医院" 27 "骨伤医院" ///
					28 "骨科医院" 29 "麻风病医院"
	label val  a2 a2 

	label define  a3 1 "营利性医疗机构" 2 "非营利性医疗机构"
	label val   a3  a3 

	label define a6 1 "个人" 2 "事业单位" 3 "企业" 4 "其他社会组织" 5 "其他行政部门" 6 "卫生行政部门" 7 "社会团体" 
	label val  a6 a6 

	label define  a7 1 "中央属" 2 "县级市（省辖市区）属" 3 "县（旗）属" 4 "省辖市（地区、州、直辖市区）属" 5 "省（自治区、直辖市）属" 6 "镇属" 
	label val   a7  a7   
		
	label define  a8 0 "否" 1 "是"
	label val   a8  a8 

	label define level 0 "未定级" 1 "一级" 2 "二级" 3 "三级"
	label val level level

	label define grade 0 "未定级" 1 "丙等" 2 "乙等" 3 "甲等"
	label val grade grade

	label define region_cen 0 "否" 1 "是"
	label val region_cen region_cen

	label define regcen_type 1 "专科性" 2 "综合性"
	label val regcen_type regcen_type

	label define regcen_lev 1 "市级" 2 "省级" 3 "国家级"
	label val regcen_lev regcen_lev

	***rechecking
	foreach var in a1 a2 a3 a6 a7 a8 level grade region_cen regcen_type regcen_lev{
	tab `var' `var'N,m
	}
	drop *N

	tostring setup, replace
	tostring year_setup, replace
	
	save "data/derived/hosp_year_report_`doc'.dta", replace

end
***
	medinst_dta, doc(2016)
	medinst_dta, doc(2015)
	medinst_dta, doc(2014)
	medinst_dta, doc(2013)
	medinst_dta, doc(2012)
	
