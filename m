Return-Path: <linux-crypto+bounces-3780-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E6F8AD85D
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Apr 2024 01:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5A328130D
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Apr 2024 23:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04116D9AB;
	Mon, 22 Apr 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="L+8WnMgz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B273D566;
	Mon, 22 Apr 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826252; cv=none; b=u3DIaucy3r2j0q7Mu8B+fmOi84+uond212wzBHil86D3OwWrSW/V/9nOKeiJyiH3oMnjREFPSFaShgk0Fmdy9vydc8C8RtGsz1/Wv4RalX6PnNnSwj1hEaYC7gk4uLXpQAxXhCd/b/RxUK6KNX1x1wMqfBgpgK2EkXTEC/9LO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826252; c=relaxed/simple;
	bh=lkdXlLGf0lNY5rWto4L1lMhHWwOx4y9Lhd9xf4nrg7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdT1LKOFy5yoBBtvvTaTS7hYIguTxdsvDmKoVDvmwHgZXJfRgVXrDF8lUd63dgGcgpnB8PUc88pdJKpwJFVWdQChP7DXQULC1DguY8dwb6Nf0ypxmULRikmYGupgi5e7CRSpucI0UaArp9xXfALAnzLkAVx2Qd3feDuTqQH/5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=L+8WnMgz; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKgaQW016275;
	Mon, 22 Apr 2024 15:50:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=XbkPgDLMGSh3ugFy/fCWFLL/sVEChdV9/csNiyeI/gk=;
 b=L+8WnMgzgygNJUZE3idr/djeKmocZ3zqGRUunMHwfgeo8pLKVBq8kluVLmFbhVntfpLc
 R6tE1DW3dNJIiqmP4OHJUveJJWsh96A7cP9tYeLSsiDjGV+X7CIo8E6sk9IwrYOD52+D
 5xmn5zBxWhbbowkWDNkLd7Hxt1DWrNcWSXXSYj8rPm2yLBxi5nnoJRu5fc7pxDU8/d1y
 OHXZXWK21IX0O6Lo14VD/tisE9QVZGWs1lTY2S5Gn/RSQNSGVV5CuwcRx+R5TdbF53L2
 lpE3vbSJxHCiGOblnXhdmflMgl8UEqs1X8C+kvEvwxSCofAbDeMJZDCKqsCJ/ipEBWhi Jg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xm91mb8gw-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Apr 2024 15:50:41 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 22 Apr 2024 22:50:37 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v10 3/4] selftests: bpf: crypto skcipher algo selftests
Date: Mon, 22 Apr 2024 15:50:23 -0700
Message-ID: <20240422225024.2847039-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422225024.2847039-1-vadfed@meta.com>
References: <20240422225024.2847039-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MhTtrIIl3ifFzW9S1_d-zIuxOZ2sAyIm
X-Proofpoint-GUID: MhTtrIIl3ifFzW9S1_d-zIuxOZ2sAyIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02

Add simple tc hook selftests to show the way to work with new crypto
BPF API. Some tricky dynptr initialization is used to provide empty iv
dynptr. Simple AES-ECB algo is used to demonstrate encryption and
decryption of fixed size buffers.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v9 -> v10:
- reorder calls in tests to have proper error path
- change test programs to use global vars to fill bpf_crypto_params
  structure
- removed crypto_shared.h as there is no need for it anymore
- improved bpf_tc_detach part with error check
- improved comments about using bpf_dynptr in production
v8 -> v9:
- adjust tests to use new bpf_crypto_create API
v7 -> v8:
- use sizeof for all constant buffer operations
- make local functions static
- initialize crypto_key value via access to bss data
- add bpf_skb_pull_data to be sure that data is linear
- some comments around tricky dynptr initialization
v6 -> v7:
- style issues
v5 -> v6:
- use AF_ALG socket to confirm proper algorithm test
- adjust test kernel config to include AF_ALG
v4 -> v5:
- adjust selftests to use new naming
- restore tests on aarch64 and s390 as no sg lists are used
v3 -> v4:
- adjust selftests to use new syntax of helpers
- add tests for acquire and release
v2 -> v3:
- disable tests on s390 and aarch64 because of unknown Fatal exception
  in sg_init_one
v1 -> v2:
- add CONFIG_CRYPTO_AES and CONFIG_CRYPTO_ECB to selftest build config
  suggested by Daniel
---
 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/crypto_sanity.c  | 197 ++++++++++++++++++
 .../selftests/bpf/progs/crypto_basic.c        |  68 ++++++
 .../selftests/bpf/progs/crypto_common.h       |  66 ++++++
 .../selftests/bpf/progs/crypto_sanity.c       | 169 +++++++++++++++
 5 files changed, 505 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index afd675b1bf80..eeabd798bc3a 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -13,7 +13,12 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_CRYPTO_SKCIPHER=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_AES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
new file mode 100644
index 000000000000..b1a3a49a822a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/in6.h>
+#include <linux/if_alg.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "crypto_sanity.skel.h"
+#include "crypto_basic.skel.h"
+
+#define NS_TEST "crypto_sanity_ns"
+#define IPV6_IFACE_ADDR "face::1"
+static const unsigned char crypto_key[] = "testtest12345678";
+static const char plain_text[] = "stringtoencrypt0";
+static int opfd = -1, tfmfd = -1;
+static const char algo[] = "ecb(aes)";
+static int init_afalg(void)
+{
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type = "skcipher",
+		.salg_name = "ecb(aes)"
+	};
+
+	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (tfmfd == -1)
+		return errno;
+	if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) == -1)
+		return errno;
+	if (setsockopt(tfmfd, SOL_ALG, ALG_SET_KEY, crypto_key, 16) == -1)
+		return errno;
+	opfd = accept(tfmfd, NULL, 0);
+	if (opfd == -1)
+		return errno;
+	return 0;
+}
+
+static void deinit_afalg(void)
+{
+	if (tfmfd != -1)
+		close(tfmfd);
+	if (opfd != -1)
+		close(opfd);
+}
+
+static void do_crypt_afalg(const void *src, void *dst, int size, bool encrypt)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	char cbuf[CMSG_SPACE(4)] = {0};
+	struct iovec iov;
+
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	cmsg->cmsg_len = CMSG_LEN(4);
+	*(__u32 *)CMSG_DATA(cmsg) = encrypt ? ALG_OP_ENCRYPT : ALG_OP_DECRYPT;
+
+	iov.iov_base = (char *)src;
+	iov.iov_len = size;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	sendmsg(opfd, &msg, 0);
+	read(opfd, dst, size);
+}
+
+void test_crypto_basic(void)
+{
+	RUN_TESTS(crypto_basic);
+}
+
+void test_crypto_sanity(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct nstoken *nstoken = NULL;
+	struct crypto_sanity *skel;
+	char afalg_plain[16] = {0};
+	char afalg_dst[16] = {0};
+	struct sockaddr_in6 addr;
+	int sockfd, err, pfd;
+	socklen_t addrlen;
+	u16 udp_test_port;
+
+	skel = crypto_sanity__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	err = init_afalg();
+	if (!ASSERT_OK(err, "AF_ALG init fail"))
+		goto fail;
+
+	qdisc_hook.ifindex = if_nametoindex("lo");
+	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
+		goto fail;
+
+	skel->bss->key_len = 16;
+	skel->bss->authsize = 0;
+	udp_test_port = skel->data->udp_test_port;
+	memcpy(skel->bss->key, crypto_key, sizeof(crypto_key));
+	snprintf(skel->bss->algo, 128, "%s", algo);
+	pfd = bpf_program__fd(skel->progs.skb_crypto_setup);
+	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "skb_crypto_setup") ||
+	    !ASSERT_OK(opts.retval, "skb_crypto_setup retval"))
+		goto fail;
+
+	if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup status"))
+		goto fail;
+
+	err = bpf_tc_hook_create(&qdisc_hook);
+	if (!ASSERT_OK(err, "create qdisc hook"))
+		goto fail;
+
+	addrlen = sizeof(addr);
+	err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, udp_test_port,
+			    (void *)&addr, &addrlen);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto fail;
+
+	tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(err, "attach encrypt filter"))
+		goto fail;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
+		goto fail;
+	err = sendto(sockfd, plain_text, sizeof(plain_text), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(plain_text), "encrypt send"))
+		goto fail;
+
+	do_crypt_afalg(plain_text, afalg_dst, sizeof(afalg_dst), true);
+
+	if (!ASSERT_OK(skel->bss->status, "encrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_dst, sizeof(afalg_dst), "encrypt AF_ALG"))
+		goto fail;
+
+	tc_attach_enc.flags = tc_attach_enc.prog_fd = tc_attach_enc.prog_id = 0;
+	err = bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(err, "bpf_tc_detach encrypt"))
+		goto fail;
+
+	tc_attach_dec.prog_fd = bpf_program__fd(skel->progs.decrypt_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach_dec);
+	if (!ASSERT_OK(err, "attach decrypt filter"))
+		goto fail;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "decrypt socket"))
+		goto fail;
+	err = sendto(sockfd, afalg_dst, sizeof(afalg_dst), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(afalg_dst), "decrypt send"))
+		goto fail;
+
+	do_crypt_afalg(afalg_dst, afalg_plain, sizeof(afalg_plain), false);
+
+	if (!ASSERT_OK(skel->bss->status, "decrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_plain, sizeof(afalg_plain), "decrypt AF_ALG"))
+		goto fail;
+
+	tc_attach_dec.flags = tc_attach_dec.prog_fd = tc_attach_dec.prog_id = 0;
+	err = bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
+	ASSERT_OK(err, "bpf_tc_detach decrypt");
+
+fail:
+	close_netns(nstoken);
+	deinit_afalg();
+	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	crypto_sanity__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/crypto_basic.c b/tools/testing/selftests/bpf/progs/crypto_basic.c
new file mode 100644
index 000000000000..8cf7168b42d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_basic.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "crypto_common.h"
+
+int status;
+SEC("syscall")
+int crypto_release(void *ctx)
+{
+	struct bpf_crypto_params params = {
+		.type = "skcipher",
+		.algo = "ecb(aes)",
+		.key_len = 16,
+	};
+
+	struct bpf_crypto_ctx *cctx;
+	int err = 0;
+
+	status = 0;
+
+	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	bpf_crypto_ctx_release(cctx);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int crypto_acquire(void *ctx)
+{
+	struct bpf_crypto_params params = {
+		.type = "skcipher",
+		.algo = "ecb(aes)",
+		.key_len = 16,
+	};
+	struct bpf_crypto_ctx *cctx;
+	int err = 0;
+
+	status = 0;
+
+	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	cctx = bpf_crypto_ctx_acquire(cctx);
+	if (!cctx)
+		return -EINVAL;
+
+	bpf_crypto_ctx_release(cctx);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/crypto_common.h b/tools/testing/selftests/bpf/progs/crypto_common.h
new file mode 100644
index 000000000000..df75dac19c37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_common.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _CRYPTO_COMMON_H
+#define _CRYPTO_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+struct bpf_crypto_ctx *bpf_crypto_ctx_create(const struct bpf_crypto_params *params,
+					     u32 params__sz, int *err) __ksym;
+struct bpf_crypto_ctx *bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx) __ksym;
+void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx) __ksym;
+int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
+		       struct bpf_dynptr *dst, struct bpf_dynptr *iv) __ksym;
+int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
+		       struct bpf_dynptr *dst, struct bpf_dynptr *iv) __ksym;
+
+struct __crypto_ctx_value {
+	struct bpf_crypto_ctx __kptr * ctx;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __crypto_ctx_value);
+	__uint(max_entries, 1);
+} __crypto_ctx_map SEC(".maps");
+
+static inline struct __crypto_ctx_value *crypto_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__crypto_ctx_map, &key);
+}
+
+static inline int crypto_ctx_insert(struct bpf_crypto_ctx *ctx)
+{
+	struct __crypto_ctx_value local, *v;
+	struct bpf_crypto_ctx *old;
+	u32 key = 0;
+	int err;
+
+	local.ctx = NULL;
+	err = bpf_map_update_elem(&__crypto_ctx_map, &key, &local, 0);
+	if (err) {
+		bpf_crypto_ctx_release(ctx);
+		return err;
+	}
+
+	v = bpf_map_lookup_elem(&__crypto_ctx_map, &key);
+	if (!v) {
+		bpf_crypto_ctx_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_crypto_ctx_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _CRYPTO_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
new file mode 100644
index 000000000000..1e3d866121f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "crypto_common.h"
+
+unsigned char key[256] = {};
+u16 udp_test_port = 7777;
+u32 authsize, key_len;
+char algo[128] = {};
+char dst[16] = {};
+int status;
+
+static int skb_dynptr_validate(struct __sk_buff *skb, struct bpf_dynptr *psrc)
+{
+	struct ipv6hdr ip6h;
+	struct udphdr udph;
+	u32 offset;
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
+		return -1;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
+		return -1;
+
+	if (ip6h.nexthdr != IPPROTO_UDP)
+		return -1;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, sizeof(udph)))
+		return -1;
+
+	if (udph.dest != __bpf_htons(udp_test_port))
+		return -1;
+
+	offset = ETH_HLEN + sizeof(ip6h) + sizeof(udph);
+	if (skb->len < offset + 16)
+		return -1;
+
+	/* let's make sure that 16 bytes of payload are in the linear part of skb */
+	bpf_skb_pull_data(skb, offset + 16);
+	bpf_dynptr_from_skb(skb, 0, psrc);
+	bpf_dynptr_adjust(psrc, offset, offset + 16);
+
+	return 0;
+}
+
+SEC("syscall")
+int skb_crypto_setup(void *ctx)
+{
+	struct bpf_crypto_params params = {
+		.type = "skcipher",
+		.key_len = key_len,
+		.authsize = authsize,
+	};
+	struct bpf_crypto_ctx *cctx;
+	int err = 0;
+
+	status = 0;
+
+	if (key_len > 256) {
+		status = -EINVAL;
+		return 0;
+	}
+
+	__builtin_memcpy(&params.algo, algo, sizeof(algo));
+	__builtin_memcpy(&params.key, key, sizeof(key));
+	cctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	err = crypto_ctx_insert(cctx);
+	if (err && err != -EEXIST)
+		status = err;
+
+	return 0;
+}
+
+SEC("tc")
+int decrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	err = skb_dynptr_validate(skb, &psrc);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_ctx_value_lookup();
+	if (!v) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	ctx = v->ctx;
+	if (!ctx) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	/* dst is a global variable to make testing part easier to check. In real
+	 * production code it's better to use percpu map to get more performance.
+	 */
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	/* iv dynptr has to be initialized with 0 size, but proper memory region
+	 * has to be provided anyway
+	 */
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
+
+	return TC_ACT_SHOT;
+}
+
+SEC("tc")
+int encrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	status = 0;
+
+	err = skb_dynptr_validate(skb, &psrc);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_ctx_value_lookup();
+	if (!v) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	ctx = v->ctx;
+	if (!ctx) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	/* dst is a global variable to make testing part easier to check. In real
+	 * production code it's better to use percpu map to get more performance.
+	 */
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	/* iv dynptr has to be initialized with 0 size, but proper memory region
+	 * has to be provided anyway
+	 */
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.43.0


