/*
***统计年报数据两个表的表头不只是首行，在导入前对三个原始EXCEL作了去掉excel首行表头处理
***********************
*/
clear all 
set more off
cd "E:\" 

*****机构年报数据
capture prog drop medinst_dta
prog medinst_dta
	syntax, doc(str)
	
	*数据导成dta格式
	clear
	set more off
	import excel "data/year_report/pry/`doc'.xlsx", allstring
	save "data/temp/pry_year_report_`doc'.dta", replace
	
	*** ===============================================var label======================================================================
	use "data/temp/pry_year_report_`doc'.dta", clear
	rename (A B C D E) (num hosp hospid cons_code a1)
	rename (F G H I J) (a2 a3 a4_1 a4 a5 )
	rename (K L M N O P Q) ///
		   (a6 a7 a8 a9 setup a10 a11) 
		   
	label var num 			"序号"
	label var hosp 			"机构名称"
	label var hospid 		"机构ID"
	label var cons_code 	"组织机构代码"
	label var a1 			"经济类型代码"
	label var a2 			"卫生机构类别代码"
	label var a3 			"机构分类管理代码"
	label var a4_1			"行政区划"
	label var a4 			"行政区划代码"

	label var a5 			"乡镇街道代码"
	label var a6 			"设置/主办单位代码"
	label var a7 			"政府办卫生机构隶属关系代码"
	label var a8 			"是否分支机构"
	label var a9 			"是否建制乡镇卫生院"
	label var setup 		"单位成立时间(年)"
	label var a10			"医保定点机构"
	label var a11	 		"是否与医保经办机构直接结算"

	rename (R S T U V W) (a12 a13 a14 a15 a16 a17)
	   
	label var a12 	"是否与新农合经办机构直接结算"
	label var a13	"辖区内行政村数"
	label var a14 	"设立村卫生室的行政村数"
	label var a15 	"本单位一体化管理的村卫生室个数"
	label var a16 	"本单位下的村卫生室个数"
	label var a17 	"服务人口数（人）"

	rename (X Y Z AA AB AC AD AE) (contractor contractor_act employee emp_techhealth emp_techhealth1 emp_techhealth2 emp_techhealth2_1 emp_techhealth2_2)
			
	label var contractor 		"本年编制人数"
	label var contractor_act 	"其中：在编人数"
	label var employee 			"在职职工数"
	label var emp_techhealth 	"卫生技术人员"
	label var emp_techhealth1 	"执业医师 "
	label var emp_techhealth2 	"职业助理医师"
	label var emp_techhealth2_1 "执业（助理）医师中，注册为全科医学专业的人数"
	label var emp_techhealth2_2 "执业（助理）医师中，取得全科医生培训合格证的人数"

	rename (AF AG AH AI AJ AK AL) (emp_techhealth3 emp_techhealth5 emp_techhealth6 emp_techhealth7 emp_techoth emp_manager emp_skiller)
	label var emp_techhealth3 	"注册护士"
	label var emp_techhealth5 	"检验技师（士）"
	label var emp_techhealth6 	"影像技师（士）"
	label var emp_techhealth7 	"其他卫生技术人员"
	label var emp_techoth 		"其他技术人员"
	label var emp_manager 		"管理人员"
	label var emp_skiller 		"工勤技能人员"

	rename (AM AN AO AP AQ AR) (training1 training2 training3 training4 training5 training6 )
	label var training1 		"参加政府举办的岗位培训人次数"
	label var training2 		"其中：领导干部参加培训人次数"
	label var training3 		"中层干部参加培训人次数"
	label var training4 		"其中：人事干部参加培训人次数"
	label var training5 		"接受继续医学教育人数"
	label var training6 		"进修半年以上人数"

	rename (AS AT AU AV AW AX AY AZ BA BB) ///
			(beds_pre beds_actual beds_day1	beds_day2 beds_day3	equip_val equip_num	equip_num1 equip_num2 equip_num3)
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

	rename (BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR) ///
			(inc_total	inc_medical	out_inc	out_inc1 out_inc3 ///
			out_incdrug out_incdrug1 out_incdrug2 out_incdrug3 ///
			out_inc7 out_inc8 out_inc5 out_inc6 out_inc4 out_incphar out_incnew)
			
	label var inc_total 	"总收入"
	label var inc_medical 	"医疗收入"
	label var out_inc 		"门诊收入"
	label var out_inc1 		"挂号收入"
	label var out_inc3 		"检查收入"
	label var out_inc4 		"化验收入"
	label var out_inc5 		"治疗收入"
	label var out_inc6 		"手术收入"
	label var out_inc7 		"卫生材料收入"
	label var out_inc8 		"一般诊疗费收入"

	label var out_incdrug 	"药品收入"
	label var out_incdrug1 	"西药收入"
	label var out_incdrug2 	"中草药收入"
	label var out_incdrug3 	"中成药收入"
	label var out_incphar 	"其他门诊收入"
	label var out_incnew 	"新技术、新项目收入"

	rename (BS BT BU BV BW BX BY BZ CA CB CC CD CE CF CG CH) ///
			(in_inc	in_inc1	in_inc2	in_inc3	in_incdrug	in_incdrug1	///
			in_incdrug2	in_incdrug3	in_inc8	in_inc9	in_inc5	in_inc6	///
			in_inc4	in_inc7	in_incoth in_incnew)
	label var in_inc 		"住院收入"
	label var in_inc1 		"其中：床位收入"
	label var in_inc2 		"诊察收入"
	label var in_inc3 		"检查收入"
	label var in_inc4 		"化验收入"
	label var in_inc5 		"治疗收入"
	label var in_inc6 		"手术收入"
	label var in_inc7 		"护理收入"
	label var in_inc8 		"卫生材料收入"
	label var in_inc9 		"一般诊疗费收入"

	label var in_incdrug 	"药品收入"
	label var in_incdrug1 	"西药收入"
	label var in_incdrug2 	"中草药收入"
	label var in_incdrug3 	"中成药收入"
	label var in_incoth 	"其他住院收入"
	label var in_incnew 	"新技术、新项目收入"

	rename (CI CJ CK CL CM CN CO CP CQ CR CS CT) ///
			(inc_subsidy inc_subsidy1 inc_subsidy1_1 inc_subsidy2 inc_subsidy3 ///
			inc_subsidy4 inc_subsidy5 inc_subsidy6 inc_OTH inc_OTHUWB inc_OTHURB inc_OTHNRC)
	label var inc_subsidy 	"财政补助收入"
	label var inc_subsidy1 	"其中：基本支出"
	label var inc_subsidy1_1 	"其中：基本公共卫生服务补助"
	label var inc_subsidy2 	"项目支出"
	label var inc_subsidy3 	"其中：基本建设资金"
	label var inc_subsidy4 	"设备购置补助"
	label var inc_subsidy5 	"重大公共卫生服务补助"
	label var inc_subsidy6 	"上级补助收入"
	label var inc_OTH 		"其他收入"
	label var inc_OTHUWB 	"总收入中:城镇职工基本医疗保险收入"
	label var inc_OTHURB 	"城镇居民基本医疗保险收入"
	label var inc_OTHNRC 	"新型农村合作医疗补偿收入"

	rename (CU CV CW CX CY CZ DA DB DC DD DE DF DG DH) ///
			(inc_totcost inc_totcost_1 inc_totcost_2 inc_totcost_3 inc_totcost_4 inc_totcost_5 ///
			inc_totcost_6 inc_totcost_7 inc_totcost_8 inc_totcost_9 inc_totcost5 inc_totcost_10 inc_totcost_11 inc_totcost_12)

	label var inc_totcost 	"总费用/支出"
	label var inc_totcost_1 "医疗支出"
	label var inc_totcost_2 "其中：人员经费"
	label var inc_totcost_3 "其中：基本工资"
	label var inc_totcost_4 "津贴补贴"
	label var inc_totcost_5 "奖金"
	label var inc_totcost_6 "社会保障缴费"
	label var inc_totcost_7 "绩效工资"
	label var inc_totcost_8 "内：基础性绩效工资"
	label var inc_totcost_9 "奖励性绩效工资"
	label var inc_totcost5  "离退休费"
	label var inc_totcost_10 "药品支出"
	label var inc_totcost_11 "材料支出"
	label var inc_totcost_12 "其中：卫材支出"

	rename (DI DJ DK DL DM DN DO DP DQ DR DS DT DU) ///
			(inc_pubcost_1 inc_pubcost_2 inc_pubcost_3 inc_pubcost_4 inc_pubcost_5 ///
			inc_pubcost_6 inc_pubcost_7 inc_pubcost_8 inc_pubcost_9 inc_pubcost_10 inc_pubcost_11 inc_pubcost_12 inc_pubcost_13)
	label var inc_pubcost_1 "公共卫生支出"
	label var inc_pubcost_2 "其中：人员经费"
	label var inc_pubcost_3 "其中：基本工资"
	label var inc_pubcost_4 "津贴补贴"
	label var inc_pubcost_5 "奖金"
	label var inc_pubcost_6 "社会保障缴费"
	label var inc_pubcost_7 "绩效工资"
	label var inc_pubcost_8 "内：基础性绩效工资"
	label var inc_pubcost_9 "奖励性绩效工资"
	label var inc_pubcost_10  "离退休费"
	label var inc_pubcost_11 "药品支出"
	label var inc_pubcost_12 "材料支出"
	label var inc_pubcost_13 "其中：卫材支出"
	
	rename (DI DJ DK DL DM DN DO DP DQ DR DS DT DU) ///
			(inc_pubcost_1 inc_pubcost_2 inc_pubcost_3 inc_pubcost_4 inc_pubcost_5 ///
			inc_pubcost_6 inc_pubcost_7 inc_pubcost_8 inc_pubcost_9 inc_pubcost_10 inc_pubcost_11 inc_pubcost_12 inc_pubcost_13)
	label var inc_pubcost_1 "公共卫生支出"
	label var inc_pubcost_2 "其中：人员经费"
	label var inc_pubcost_3 "其中：基本工资"

	rename (DV DW) ///
		   (spend_finance spend_other)
		   
	label var spend_finance	"财政基建设备补助支出"
	label var spend_other	"其他支出"
	
	rename (EC ED EE EF EG EH EI EJ EK EL EM EN EO EP EQ ER ES ET EU EV EW) ///
			(service_quant service_quant1 service_quant2 service_quant3 health_record ///
			health_record1 health_consult health_educ immu_6 health_man_1 health_man_2 ///
			health_man_3 hyper_man	diab_man psycho_man	tb_man commu_report ///
			surveil_report herb_man	herb_man1 herb_man2)
	label var service_quant "年末服务(常住)人口数"
	label var service_quant1 "其中：0-6岁儿童数"
	label var service_quant2 "内：0-3岁儿童数"
	label var service_quant3 "65岁以上人口数"
	label var health_record "年末居民健康档案累计建档人数"
	label var health_record1 "其中：规范化电子建档人数"
	label var health_consult "年内公众健康咨询活动总受益人数"
	label var health_educ "年内接受健康教育人次数"
	label var immu_6 "年内0-6岁儿童国家免疫规划接种人次数"
	label var health_man_1 "年内0-6岁儿童健康管理人数"
	label var health_man_2 "年末孕产妇健康管理人数"
	label var health_man_3 "年末65岁以上老人健康管理人数"
	label var hyper_man "年末高血压规范管理人数"
	label var diab_man "年末糖尿病规范管理人数"
	label var psycho_man "年末重性精神病规范管理人数"
	label var tb_man "年末肺结核患者健康管理人数"
	label var commu_report "年内传染病和突发公共卫生事件报告例数"
	label var surveil_report "年内卫生监督协管信息报告例数"
	label var herb_man "年末中医药健康管理人数"
	label var herb_man1 "其中：0-3岁儿童中医药健康管理人数"
	label var herb_man2 "65岁以上老人中医药健康管理人数"

	***==================================================================var correction========================================================
	local vars a1 a2 a3 a6 a7 a8
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
	replace  a2 = "30"  if a2 == "街道卫生院" 
	replace  a2 = "31"  if a2 == "社区卫生服务站" 
	replace  a2 = "32"  if a2 == "社区卫生服务中心" 
	replace  a2 = "33"  if a2 == "乡卫生院" 
	replace  a2 = "34"  if a2 == "中心卫生院" 


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
	replace  a7 = "7" if a7 == "街道属"
	replace  a7 = "8" if a7 == "乡属"
	replace  a7 = "." if a7 == ""

	*是否分支机构
	tab a8,m
	replace  a8 = "1" if a8 == "是"
	replace  a8 = "0" if a8 == "否"

	*单位成立时间(年)
	gen year_setup  = substr(setup, 1, 4)
	***================================================================value label===============================================================
	destring, replace

	label define a1 1 "内资" 2 "国有全资" 3 "集体全资" 4 "股份合作" 5 "联营" 6 "有限责任（公司）" 7 "股份有限（公司）" 8 "私有" ///
					9 "其他内资" 10 "内地和港澳台合作" 11 "中外合资" 12 "其他"
	label val  a1 a1  
			 
	label define a2 1 "中医（综合）医院" 2 "中西医结合医院" 3 "传染病医院" 4 "儿童医院" 5 "其他专科医院" 6 "其他中医专科医院" ///
					7 "其他民族医院" 8 "口腔医院" 9 "妇产（科）医院" 10 "妇幼保健院" 11 "康复医院" 12 "心血管病医院" 13 "护理院" ///
					14 "整形外科医院" 15 "疗养院" 16 "皮肤病医院" 17 "眼科医院" 18 "精神病医院" 19 "综合医院" 20 "美容医院" ///
					21 "耳鼻喉科医院" 22 "职业病医院" 23 "肛肠医院" 24 "肿瘤医院" 25 "胸科医院" 26 "藏医院" 27 "骨伤医院" ///
					28 "骨科医院" 29 "麻风病医院" 30 "街道卫生院" 31 "社区卫生服务站" 32 "社区卫生服务中心" 33 "乡卫生院" 34 "中心卫生院"
	label val  a2 a2 

	label define  a3 1 "营利性医疗机构" 2 "非营利性医疗机构"
	label val   a3  a3 

	label define a6 1 "个人" 2 "事业单位" 3 "企业" 4 "其他社会组织" 5 "其他行政部门" 6 "卫生行政部门" 7 "社会团体" 
	label val  a6 a6 

	label define  a7 1 "中央属" 2 "县级市（省辖市区）属" 3 "县（旗）属" 4 "省辖市（地区、州、直辖市区）属" ///
						5 "省（自治区、直辖市）属" 6 "镇属" 7 "街道属" 8 "乡属"
	label val   a7  a7   
		
	label define  a8 0 "否" 1 "是"
	label val   a8  a8 

	***rechecking
	foreach var in a1 a2 a3 a6 a7 a8{
	tab `var' `var'N,m
	}
	drop *N

	tostring setup, replace
	tostring year_setup, replace
	*de
	*codebook
	tostring a4, replace
	gen pryinst = 1
	save "data/derived/pry_year_report_`doc'.dta", replace

end
***
	medinst_dta, doc(2016)
	medinst_dta, doc(2015)
	medinst_dta, doc(2014)
	medinst_dta, doc(2013)
	medinst_dta, doc(2012)
	
