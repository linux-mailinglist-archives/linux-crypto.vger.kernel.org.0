Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85092B21B8
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMRNt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 12:13:49 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:15514
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKMRNs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 12:13:48 -0500
X-IronPort-AV: E=Sophos;i="5.77,476,1596492000"; 
   d="scan'208";a="364498413"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 18:14:00 +0100
Date:   Fri, 13 Nov 2020 18:14:00 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
cc:     qat-linux@intel.com, Denis Efremov <efremov@linux.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: [PATCH] crypto: qat - fix excluded_middle.cocci warnings
Message-ID: <alpine.DEB.2.22.394.2011131811110.2840@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: kernel test robot <lkp@intel.com>

 Condition !A || A && B is equivalent to !A || B.

Generated by: scripts/coccinelle/misc/excluded_middle.cocci

Fixes: b76f0ea01312 ("coccinelle: misc: add excluded_middle.cocci script")
CC: Denis Efremov <efremov@linux.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
commit: b76f0ea013125358d1b4ca147a6f9b6883dd2493 coccinelle: misc: add excluded_middle.cocci script
:::::: branch date: 14 hours ago
:::::: commit date: 8 weeks ago

Please take the patch only if it's a positive warning. Thanks!

 adf_dev_mgr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/qat/qat_common/adf_dev_mgr.c
+++ b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
@@ -152,7 +152,7 @@ int adf_devmgr_add_dev(struct adf_accel_
 	atomic_set(&accel_dev->ref_count, 0);

 	/* PF on host or VF on guest */
-	if (!accel_dev->is_vf || (accel_dev->is_vf && !pf)) {
+	if (!accel_dev->is_vf || !pf) {
 		struct vf_id_map *map;

 		list_for_each(itr, &accel_table) {
@@ -248,7 +248,7 @@ void adf_devmgr_rm_dev(struct adf_accel_
 		       struct adf_accel_dev *pf)
 {
 	mutex_lock(&table_lock);
-	if (!accel_dev->is_vf || (accel_dev->is_vf && !pf)) {
+	if (!accel_dev->is_vf || !pf) {
 		id_map[accel_dev->accel_id] = 0;
 		num_devices--;
 	} else if (accel_dev->is_vf && pf) {
