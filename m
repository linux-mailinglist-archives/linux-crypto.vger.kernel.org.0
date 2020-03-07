Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8917C9D2
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Mar 2020 01:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCGAhz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Mar 2020 19:37:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726237AbgCGAhy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Mar 2020 19:37:54 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0270JdxP073148;
        Fri, 6 Mar 2020 19:37:41 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ykatbahth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 19:37:41 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0270V8gs117136;
        Fri, 6 Mar 2020 19:37:40 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ykatbahtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 19:37:40 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0270ElG2000406;
        Sat, 7 Mar 2020 00:37:40 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2yffk7w38k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Mar 2020 00:37:40 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0270bcBw44106200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 7 Mar 2020 00:37:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3C9FC6059;
        Sat,  7 Mar 2020 00:37:38 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B6EC6057;
        Sat,  7 Mar 2020 00:37:38 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  7 Mar 2020 00:37:38 +0000 (GMT)
Subject: [PATCH v3 7/9] crypto/nx: Enable and setup GZIP compresstion type
From:   Haren Myneni <haren@linux.ibm.com>
To:     herbert@gondor.apana.org.au
Cc:     mpe@ellerman.id.au, mikey@neuling.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        npiggin@gmail.com
In-Reply-To: <1583540877.9256.24.camel@hbabu-laptop>
References: <1583540877.9256.24.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 06 Mar 2020 16:37:35 -0800
Message-ID: <1583541455.9256.47.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_09:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=1 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070000
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Changes to probe GZIP device-tree nodes, open RX windows and setup
GZIP compression type. No plans to provide GZIP usage in kernel right
now, but this patch enables GZIP for user space usage.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/crypto/nx/nx-common-powernv.c | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index 82dfa60..f570691 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -65,6 +65,7 @@ struct nx_coproc {
  * Using same values as in skiboot or coprocessor type representing
  * in NX workbook.
  */
+#define NX_CT_GZIP	(2)	/* on P9 and later */
 #define NX_CT_842	(3)
 
 static int (*nx842_powernv_exec)(const unsigned char *in,
@@ -819,6 +820,9 @@ static int __init vas_cfg_coproc_info(struct device_node *dn, int chip_id,
 	if (type == NX_CT_842)
 		ret = nx_set_ct(coproc, priority, VAS_COP_TYPE_842_HIPRI,
 			VAS_COP_TYPE_842);
+	else if (type == NX_CT_GZIP)
+		ret = nx_set_ct(coproc, priority, VAS_COP_TYPE_GZIP_HIPRI,
+				VAS_COP_TYPE_GZIP);
 
 	if (ret)
 		goto err_out;
@@ -867,12 +871,16 @@ static int __init vas_cfg_coproc_info(struct device_node *dn, int chip_id,
 	return ret;
 }
 
-static int __init nx_coproc_init(int chip_id, int ct_842)
+static int __init nx_coproc_init(int chip_id, int ct_842, int ct_gzip)
 {
 	int ret = 0;
 
 	if (opal_check_token(OPAL_NX_COPROC_INIT)) {
 		ret = opal_nx_coproc_init(chip_id, ct_842);
+
+		if (!ret)
+			ret = opal_nx_coproc_init(chip_id, ct_gzip);
+
 		if (ret) {
 			ret = opal_error_code(ret);
 			pr_err("Failed to initialize NX for chip(%d): %d\n",
@@ -902,8 +910,8 @@ static int __init find_nx_device_tree(struct device_node *dn, int chip_id,
 static int __init nx_powernv_probe_vas(struct device_node *pn)
 {
 	int chip_id, vasid, ret = 0;
+	int ct_842 = 0, ct_gzip = 0;
 	struct device_node *dn;
-	int ct_842 = 0;
 
 	chip_id = of_get_ibm_chip_id(pn);
 	if (chip_id < 0) {
@@ -920,19 +928,24 @@ static int __init nx_powernv_probe_vas(struct device_node *pn)
 	for_each_child_of_node(pn, dn) {
 		ret = find_nx_device_tree(dn, chip_id, vasid, NX_CT_842,
 					"ibm,p9-nx-842", &ct_842);
+
+		if (!ret)
+			ret = find_nx_device_tree(dn, chip_id, vasid,
+				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);
+
 		if (ret)
 			return ret;
 	}
 
-	if (!ct_842) {
-		pr_err("NX842 FIFO nodes are missing\n");
+	if (!ct_842 || !ct_gzip) {
+		pr_err("NX FIFO nodes are missing\n");
 		return -EINVAL;
 	}
 
 	/*
 	 * Initialize NX instance for both high and normal priority FIFOs.
 	 */
-	ret = nx_coproc_init(chip_id, ct_842);
+	ret = nx_coproc_init(chip_id, ct_842, ct_gzip);
 
 	return ret;
 }
@@ -1072,10 +1085,19 @@ static __init int nx_compress_powernv_init(void)
 		nx842_powernv_exec = nx842_exec_icswx;
 	} else {
 		/*
+		 * Register VAS user space API for NX GZIP so
+		 * that user space can use GZIP engine.
+		 * 842 compression is supported only in kernel.
+		 */
+		ret = vas_register_coproc_api(THIS_MODULE);
+
+		/*
 		 * GZIP is not supported in kernel right now.
 		 * So open tx windows only for 842.
 		 */
-		ret = nx_open_percpu_txwins();
+		if (!ret)
+			ret = nx_open_percpu_txwins();
+
 		if (ret) {
 			nx_delete_coprocs();
 			return ret;
@@ -1096,6 +1118,15 @@ static __init int nx_compress_powernv_init(void)
 
 static void __exit nx_compress_powernv_exit(void)
 {
+	/*
+	 * GZIP engine is supported only in power9 or later and nx842_ct
+	 * is used on power8 (icswx).
+	 * VAS API for NX GZIP is registered during init for user space
+	 * use. So delete this API use for GZIP engine.
+	 */
+	if (!nx842_ct)
+		vas_unregister_coproc_api();
+
 	crypto_unregister_alg(&nx842_powernv_alg);
 
 	nx_delete_coprocs();
-- 
1.8.3.1



