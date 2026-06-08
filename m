Return-Path: <linux-crypto+bounces-24960-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9H9QBgLpJmrOmwIAu9opvQ
	(envelope-from <linux-crypto+bounces-24960-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 08 Jun 2026 18:08:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB1658839
	for <lists+linux-crypto@lfdr.de>; Mon, 08 Jun 2026 18:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=M8JIVBAe;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24960-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24960-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60F4C30A84AE
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jun 2026 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4540BCB1;
	Mon,  8 Jun 2026 15:01:17 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AA40B38A
	for <linux-crypto@vger.kernel.org>; Mon,  8 Jun 2026 15:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930877; cv=none; b=r/xJRBXfjmeQeNBTzL+XoXQxwYq93u8XUsV53GjtsOGjWKtz9SRmgf3pNVcoGGs7fmiJE3qGKvQ6DWoNGqkxrpS4v4UIma+UarCkog2DjjXPjl3Mtq3DjmVt0vIPTXfR9oMVMUXAa8cUbEa8ESu6Jks8OOxYez9MKxxWrOBPg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930877; c=relaxed/simple;
	bh=xOsBiar0SrK1NKqeyGjcLM8ZLx8NWWaQlyLPLB5v5c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R67QreZNPLfCu8tTBvSAmsYUuuTtmVWJY5Hnl5z3fkjEjVbV7BPqEUOb/dPLCa9Xva7g0VXKWQZ9JBXTNm6ssMEYYODBOA7U0stwTK7LcTv5d70QgHgDJpYbwkWXfra/ZBDfuq5+CLs5n+WmzMlFQ4lLPwQtiEem2OMeB1VIkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8JIVBAe; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780930871; x=1812466871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xOsBiar0SrK1NKqeyGjcLM8ZLx8NWWaQlyLPLB5v5c0=;
  b=M8JIVBAe0s7Td1Hchgx0tlhgnubFUqYROF8KrHmUwIJ5j3W23x3+6OHC
   BLiYDVsOIEh8Ydrx+NF4OkRfN2UbFOONpCEGmYtwUzZgQxhJzXsjC5LoL
   ZoDbtHJUs9k195EHSWON3KTrlUykUb6t3lG1Rwmnmf2AZ/ozyPsg1eRho
   lOi6s6WFzp0Xp8PrbI5ea8fGSqgUmDfZNtPKbCpGD3rL76Xjqudn4sMbn
   oyZXbOmieDrPgbyWYwcZ6jb8ZqSKX0eP2Qwnmi4Yj6/HmhjLCV6gXm7EB
   VsjlkS6BB/IKfx9LOl9XRetRlqaD25jHJIXA5K1i2P92t5hpYu22rGcZP
   A==;
X-CSE-ConnectionGUID: J0ZRDHmaQ5i4LVyEUoy7CA==
X-CSE-MsgGUID: tZKRvBViToe8wLaY+KKfuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81412970"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81412970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:01:10 -0700
X-CSE-ConnectionGUID: HqPU0AvjRU+vzj+7WW7hIQ==
X-CSE-MsgGUID: 9mN86Wh0TZuAvGh68qFFDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="250491548"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by orviesa005.jf.intel.com with ESMTP; 08 Jun 2026 08:01:10 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH] crypto: qat - cancel work on re-enable SR-IOV timeout
Date: Mon,  8 Jun 2026 15:59:40 +0100
Message-ID: <20260608150104.135313-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24960-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:giovanni.cabiddu@intel.com,m:ahsan.atta@intel.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[giovanni.cabiddu@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giovanni.cabiddu@intel.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12DB1658839

The QAT reset worker queues SR-IOV reenable work using a work_struct and
completion embedded in an on-stack adf_sriov_dev_data. If the completion
wait times out, the reset worker can return while device_sriov_wq still
holds or executes the stack-backed work item.

Cancel the work on the device_sriov_wq on timeout before the stack frame
unwinds.

Fixes: 4469f9b23468 ("crypto: qat - re-enable sriov after pf reset")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
---
 drivers/crypto/intel/qat/qat_common/adf_aer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index d58cd7fbf707..afded3030e9a 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -189,6 +189,8 @@ static void adf_device_reset_worker(struct work_struct *work)
 	queue_work(device_sriov_wq, &sriov_data.sriov_work);
 	if (wait_for_completion_timeout(&sriov_data.compl, wait_jiffies))
 		adf_pf2vf_notify_restarted(accel_dev);
+	else
+		cancel_work_sync(&sriov_data.sriov_work);
 
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);

base-commit: 36d82ddc0f8a88444e8d65646a3c43147005ed35
-- 
2.54.0


