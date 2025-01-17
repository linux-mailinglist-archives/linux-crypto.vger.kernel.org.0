Return-Path: <linux-crypto+bounces-9126-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D6A15742
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jan 2025 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86052164A11
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jan 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90ED1E3DC3;
	Fri, 17 Jan 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alfpyTt7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480A1E3776
	for <linux-crypto@vger.kernel.org>; Fri, 17 Jan 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139071; cv=none; b=RV8kDAysBNZJW1zxfEBgaa4b268ofnDDcohwJyUjaWgjMPat6iaEs9lE/+1z0YqQqBf+WuxcHO2kqjy7wB5IaO/TVJcluCIVdAth4z6SO8BcSk3RI4LXanxhIH8Fys1lBBJ3qDrzHoYQf5tX9wx2C8NWrrNeqNuv5AzIntnmFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139071; c=relaxed/simple;
	bh=UdtPFfo6IEtlO4Uu///IapEL8v8C+JSrs/dW1hsJHR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrpfMKjIA+sjrUw4PKwIN4ryVwbD8jDCvvKHtnLc7NJR0wmyrRT5ds4Mr0+PWOQgWy8ZJfM4y6zziBlb3dkezSuZRLLd5MTF/jEZFkXe5fw4fdYbM06SatqxmHP6jav+ySGSh++lEBWgqhCy3MRpDO5IB4dnKlHg3pCI4DEf84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alfpyTt7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQNDLqN4JS/4d8Io4N4k5H4thf2YC8MNS4Zy3imAwnM=;
	b=alfpyTt7Q4pKeOQs7v/9cSnxusVRg+TQ1EarqOfA8VZnYUPdNIlqFOql6SYzu25PvJ1swu
	VWp+XOZJW5EYyZ0xgxeXfXYXKv6Zb2zv45FL3Tf2b8QgblHPoQmbvT0qImBZnbCpHuMklg
	nvAuWKoIJM46ABv7VWbh9RvLDw+T5bA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-lV1UsthFMy-8OdFhMP4hbg-1; Fri,
 17 Jan 2025 13:37:46 -0500
X-MC-Unique: lV1UsthFMy-8OdFhMP4hbg-1
X-Mimecast-MFC-AGG-ID: lV1UsthFMy-8OdFhMP4hbg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2280519560B4;
	Fri, 17 Jan 2025 18:37:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9391955F10;
	Fri, 17 Jan 2025 18:37:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 20/24] rxrpc: Add the security index for yfs-rxgk
Date: Fri, 17 Jan 2025 18:35:29 +0000
Message-ID: <20250117183538.881618-21-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the security index and abort codes for the YFS variant of rxgk.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/afs/misc.c              | 13 +++++++++++++
 include/uapi/linux/rxrpc.h | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index b8180bf2281f..57f779804d50 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -103,6 +103,19 @@ int afs_abort_to_error(u32 abort_code)
 	case RXKADDATALEN:	return -EKEYREJECTED;
 	case RXKADILLEGALLEVEL:	return -EKEYREJECTED;
 
+	case RXGK_INCONSISTENCY:	return -EPROTO;
+	case RXGK_PACKETSHORT:		return -EPROTO;
+	case RXGK_BADCHALLENGE:		return -EPROTO;
+	case RXGK_BADETYPE:		return -ENOPKG;
+	case RXGK_BADLEVEL:		return -EKEYREJECTED;
+	case RXGK_BADKEYNO:		return -EKEYREJECTED;
+	case RXGK_EXPIRED:		return -EKEYEXPIRED;
+	case RXGK_NOTAUTH:		return -EKEYREJECTED;
+	case RXGK_BAD_TOKEN:		return -EKEYREJECTED;
+	case RXGK_SEALED_INCON:		return -EKEYREJECTED;
+	case RXGK_DATA_LEN:		return -EPROTO;
+	case RXGK_BAD_QOP:		return -EKEYREJECTED;
+
 	case RXGEN_OPCODE:	return -ENOTSUPP;
 
 	default:		return -EREMOTEIO;
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index 8f8dc7a937a4..0e296d219191 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -73,6 +73,7 @@ enum rxrpc_cmsg_type {
 #define RXRPC_SECURITY_RXKAD	2	/* kaserver or kerberos 4 */
 #define RXRPC_SECURITY_RXGK	4	/* gssapi-based */
 #define RXRPC_SECURITY_RXK5	5	/* kerberos 5 */
+#define RXRPC_SECURITY_YFS_RXGK	6	/* YFS gssapi-based */
 
 /*
  * RxRPC-level abort codes
@@ -118,4 +119,20 @@ enum rxrpc_cmsg_type {
 #define RXKADDATALEN		19270411	/* user data too long */
 #define RXKADILLEGALLEVEL	19270412	/* caller not authorised to use encrypted conns */
 
+/*
+ * RxGK GSSAPI security abort codes.
+ */
+#define RXGK_INCONSISTENCY	1233242880	/* Security module structure inconsistent */
+#define RXGK_PACKETSHORT	1233242881	/* Packet too short for security challenge */
+#define RXGK_BADCHALLENGE	1233242882	/* Invalid security challenge */
+#define RXGK_BADETYPE		1233242883	/* Invalid or impermissible encryption type */
+#define RXGK_BADLEVEL		1233242884	/* Invalid or impermissible security level */
+#define RXGK_BADKEYNO		1233242885	/* Key version number not found */
+#define RXGK_EXPIRED		1233242886	/* Token has expired */
+#define RXGK_NOTAUTH		1233242887	/* Caller not authorized */
+#define RXGK_BAD_TOKEN		1233242888	/* Security object was passed a bad token */
+#define RXGK_SEALED_INCON	1233242889	/* Sealed data inconsistent */
+#define RXGK_DATA_LEN		1233242890	/* User data too long */
+#define RXGK_BAD_QOP		1233242891	/* Inadequate quality of protection available */
+
 #endif /* _UAPI_LINUX_RXRPC_H */


