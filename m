Return-Path: <linux-crypto+bounces-23290-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKCRL0xq52ke8AEAu9opvQ
	(envelope-from <linux-crypto+bounces-23290-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 14:15:08 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 710AB43A80E
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08C66301C5E1
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5C3BED30;
	Tue, 21 Apr 2026 12:14:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D73BE65C;
	Tue, 21 Apr 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773686; cv=none; b=jpduW8CtAjhM0ZL4MTGns+wr8Ah5IcyLNPbEmDKaJ1n6+74KsE5UFIrIUSnZKlQrfV6JwRI/nQ4V6+yMIhYuJ+fg6oy1fF75AcGVbC9DUViK5eewLmArkl+keSB2I2chhWVyRuSFpqJiiySNSqZtwfQjFl9IouHPcKrVxMyhv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773686; c=relaxed/simple;
	bh=3pQ851RbY4FOmK5weJiLy1wND1Z0t8VgUWSYvJ5AzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRXdB4SS/sDgqVYLuhp0/3fLTrs7OgTLgRYNTSHu+zoRZq8JQfz0MiT0r8+0xRqAPiYP12+ZIEqnON6I8fiUh2HgpJCpm63//VALhQo1lImFojney5wkeU/n7oNzPFMFnsAV5QmUrD/cMLo3gLnSU/6O612FdT/fb+yDkMsFBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C8035F40862; Tue, 21 Apr 2026 14:14:40 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Geoff Levand <geoff@infradead.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Anatolij Gustschin <agust@denx.de>,
	=?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Thomas Huth <thuth@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Nam Cao <namcao@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jiri Bohac <jbohac@suse.cz>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Stephen Rothwell <sfr@cab.auug.org.au>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ni <nichen@iscas.ac.cn>,
	Haren Myneni <haren@linux.ibm.com>,
	Jonathan Greental <yonatan02greental@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	=?UTF-8?q?Adrian=20Barna=C5=9B?= <abarnas@google.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Yury Norov <ynorov@nvidia.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 1/2] powerpc: Add a typos.toml file
Date: Tue, 21 Apr 2026 14:14:13 +0200
Message-ID: <20260421121420.26079-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421121420.26079-1-linkmauve@linkmauve.fr>
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23290-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[linkmauve.fr];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linkmauve.fr,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,suse.com,broadcom.com,infradead.org,denx.de,debian.org,zx2c4.com,linux.dev,redhat.com,ziepe.ca,nvidia.com,linux-foundation.org,rivosinc.com,paul-moore.com,linutronix.de,suse.cz,linuxfoundation.org,linux.intel.com,cab.auug.org.au,vivo.com,amd.com,chinatelecom.cn,linux.alibaba.com,soleen.com,arm.com,donnellan.id.au,iscas.ac.cn,google.com,aol.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	RCPT_COUNT_GT_50(0.00)[94];
	FROM_NEQ_ENVFROM(0.00)[linkmauve@linkmauve.fr,linux-crypto@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linkmauve.fr:mid,linkmauve.fr:email]
X-Rspamd-Queue-Id: 710AB43A80E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file is used by the typos tool[1] to determine which words to fix,
which ones not to fix, and what the target word should be.

[1] https://github.com/crate-ci/typos

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/typos.toml | 109 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 arch/powerpc/typos.toml

diff --git a/arch/powerpc/typos.toml b/arch/powerpc/typos.toml
new file mode 100644
index 000000000000..5c42fd2adf56
--- /dev/null
+++ b/arch/powerpc/typos.toml
@@ -0,0 +1,109 @@
+[default.extend-words]
+# All of these duplicated words tell typos not to touch them.
+# They are case-insensitive but keep the case when fixed.
+aack = "aack"
+aer = "aer"
+ahd = "ahd"
+alo = "alo"
+als = "als"
+aout = "aout"
+ba = "ba"
+buid = "buid"
+clen = "clen"
+cmo = "cmo"
+cpy = "cpy"
+daa = "daa"
+datas = "datas"
+decie = "decie"
+defin = "defin"
+divde = "divde"
+edn = "edn"
+emac = "emac"
+evn = "evn"
+extint = "extint"
+filp = "filp"
+firsr = "firsr"
+fram = "fram"
+fre = "fre"
+fpr = "fpr"
+hypen = "hypen"
+ihs = "ihs"
+indx = "indx"
+intack = "intack"
+iput = "iput"
+ist = "ist"
+iy = "iy"
+millenium = "millenium"
+mmaped = "mmaped"
+mminimal = "mminimal"
+mport = "mport"
+msis = "msis"
+nam = "nam"
+nax = "nax"
+nd = "nd"
+nin = "nin"
+nto = "nto"
+onl = "onl"
+ot = "ot"
+outout = "outout"
+parm = "parm"
+parms = "parms"
+performa = "performa"
+pevents = "pevents"
+piar = "piar"
+pn = "pn"
+ptd = "ptd"
+recal = "recal"
+rela = "rela"
+rto = "rto"
+ser = "ser"
+shw = "shw"
+shs = "shs"
+sie = "sie"
+siz = "siz"
+slq = "slq"
+sxl = "sxl"
+synopsys = "synopsys"
+systemes = "systemes"
+tbe = "tbe"
+tge = "tge"
+thr = "thr"
+thre = "thre"
+tne = "tne"
+tpe = "tpe"
+tpos = "tpos"
+tre = "tre"
+trun = "trun"
+tou = "tou"
+ue = "ue"
+unline = "unline"
+uupdate = "uupdate"
+vas = "vas"
+vor = "vor"
+wil = "wil"
+
+# These words are for typos which had two or more known fixes.
+addresse = "address"
+allowe = "allow"
+arbitrer = "arbiter"
+colose = "color"
+concatination = "concatenation"
+contants = "constants"
+contigious = "contiguous"
+defferent = "different"
+fime = "fixme"
+fo = "for"
+fom = "from"
+formt = "format"
+matrics = "metrics"
+mmaping = "mmapping"
+multipler = "multiplier"
+ony = "only"
+partions = "partitions"
+partioning = "partitioning"
+pathes = "paths"
+sensure = "ensure"
+tranditional = "traditional"
+verisions = "versions"
+wether = "whether"
+wll = "will"
-- 
2.54.0


