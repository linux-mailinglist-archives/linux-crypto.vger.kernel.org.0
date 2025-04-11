Return-Path: <linux-crypto+bounces-11657-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D780BA85875
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Apr 2025 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B088C4E3A40
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Apr 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5229AAE0;
	Fri, 11 Apr 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwHa+Mb5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036F29B204
	for <linux-crypto@vger.kernel.org>; Fri, 11 Apr 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365229; cv=none; b=Q6TXEo9C3rQx34BGMZ3opp/kGPccDayfsqzBs6S6e8iSIYlVxcwnOmthYJT65qRqwZOeUUdFDlapGyl6LK3jbNYE/Mo1Lhew9XFZWzmsn9vA0CDxGJgXpqhzdrkoCzEPOXFfNVTKR8cq/CO92xYTaJ3H/+YO/MO3Gypa85fq9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365229; c=relaxed/simple;
	bh=OB426BM0p2kUhbQOrBKo13ZJMHCjb0jc4Kvo8X9ZTO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNA+R4CR77kj8IZr65IXfo9A4ftkThWS8GEktqMAxElJ2lWw3URfZ15uEcaYNTfy8T84P+F2Et6rtmVPSJhyWRFRIM4WxrBpJOs04zGIR7mbnfgH7KFswOYH9bD6PwLV8+wvP5r24sH4WrHLG2gC1Dt6JAJoP1Fa2UmZBbGwBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwHa+Mb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gc2qEfudFxA0okgiag2VPHsjTUpgbRIn5RioL2rpa7A=;
	b=dwHa+Mb5YQxNprYPmHjO9icuiSjJoir0zz76j7QaVAEhWWWz5xIlgNNbvTGx9+xDfw/KRi
	jn4O7g1c6p90MXEBmonnHVH6vgY4zYB/lpnrT/4Khy9OG/gp8+2Zs7vTWFji+tm3DevzsO
	LUmdh6gmAuoPbd+9tBHLEIlrdEC2Rk4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-8Dp6UKgAOqi1EcCgfuOF9w-1; Fri,
 11 Apr 2025 05:53:43 -0400
X-MC-Unique: 8Dp6UKgAOqi1EcCgfuOF9w-1
X-Mimecast-MFC-AGG-ID: 8Dp6UKgAOqi1EcCgfuOF9w_1744365222
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8141196A961;
	Fri, 11 Apr 2025 09:53:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20C121955BF2;
	Fri, 11 Apr 2025 09:53:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Subject: [PATCH net-next v3 06/14] rxrpc: Add YFS RxGK (GSSAPI) security class
Date: Fri, 11 Apr 2025 10:52:51 +0100
Message-ID: <20250411095303.2316168-7-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add support for the YFS-variant RxGK security class to support
GSSAPI-derived authentication.  This also allows the use of better crypto
over the rxkad security class.

The key payload is XDR encoded of the form:

    typedef int64_t opr_time;

    const AFSTOKEN_RK_TIX_MAX = 12000; 	/* Matches entry in rxkad.h */

    struct token_rxkad {
	afs_int32 viceid;
	afs_int32 kvno;
	afs_int64 key;
	afs_int32 begintime;
	afs_int32 endtime;
	afs_int32 primary_flag;
	opaque ticket<AFSTOKEN_RK_TIX_MAX>;
    };

    struct token_rxgk {
	opr_time begintime;
	opr_time endtime;
	afs_int64 level;
	afs_int64 lifetime;
	afs_int64 bytelife;
	afs_int64 enctype;
	opaque key<>;
	opaque ticket<>;
    };

    const AFSTOKEN_UNION_NOAUTH = 0;
    const AFSTOKEN_UNION_KAD = 2;
    const AFSTOKEN_UNION_YFSGK = 6;

    union ktc_tokenUnion switch (afs_int32 type) {
	case AFSTOKEN_UNION_KAD:
	    token_rxkad kad;
	case AFSTOKEN_UNION_YFSGK:
	    token_rxgk  gk;
    };

    const AFSTOKEN_LENGTH_MAX = 16384;
    typedef opaque token_opaque<AFSTOKEN_LENGTH_MAX>;

    const AFSTOKEN_MAX = 8;
    const AFSTOKEN_CELL_MAX = 64;

    struct ktc_setTokenData {
	afs_int32 flags;
	string cell<AFSTOKEN_CELL_MAX>;
	token_opaque tokens<AFSTOKEN_MAX>;
    };

The parser for the basic token struct is already present, as is the rxkad
token type.  This adds a parser for the rxgk token type.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 include/keys/rxrpc-type.h |  17 ++++
 net/rxrpc/key.c           | 185 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/include/keys/rxrpc-type.h b/include/keys/rxrpc-type.h
index 333c0f49a9cd..0ddbe197a261 100644
--- a/include/keys/rxrpc-type.h
+++ b/include/keys/rxrpc-type.h
@@ -9,6 +9,7 @@
 #define _KEYS_RXRPC_TYPE_H
 
 #include <linux/key.h>
+#include <crypto/krb5.h>
 
 /*
  * key type for AF_RXRPC keys
@@ -31,6 +32,21 @@ struct rxkad_key {
 	u8	ticket[];		/* the encrypted ticket */
 };
 
+/*
+ * RxRPC key for YFS-RxGK (type-6 security)
+ */
+struct rxgk_key {
+	s64		begintime;	/* Time at which the ticket starts */
+	s64		endtime;	/* Time at which the ticket ends */
+	u64		lifetime;	/* Maximum lifespan of a connection (seconds) */
+	u64		bytelife;	/* Maximum number of bytes on a connection */
+	unsigned int	enctype;	/* Encoding type */
+	s8		level;		/* Negotiated security RXRPC_SECURITY_PLAIN/AUTH/ENCRYPT */
+	struct krb5_buffer key;		/* Master key, K0 */
+	struct krb5_buffer ticket;	/* Ticket to be passed to server */
+	u8		_key[];		/* Key storage */
+};
+
 /*
  * list of tokens attached to an rxrpc key
  */
@@ -40,6 +56,7 @@ struct rxrpc_key_token {
 	struct rxrpc_key_token *next;	/* the next token in the list */
 	union {
 		struct rxkad_key *kad;
+		struct rxgk_key *rxgk;
 	};
 };
 
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 8c99cf19b19d..9fdc1f031c9d 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -129,6 +129,160 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 	return 0;
 }
 
+static u64 xdr_dec64(const __be32 *xdr)
+{
+	return (u64)ntohl(xdr[0]) << 32 | (u64)ntohl(xdr[1]);
+}
+
+static time64_t rxrpc_s64_to_time64(s64 time_in_100ns)
+{
+	bool neg = false;
+	u64 tmp = time_in_100ns;
+
+	if (time_in_100ns < 0) {
+		tmp = -time_in_100ns;
+		neg = true;
+	}
+	do_div(tmp, 10000000);
+	return neg ? -tmp : tmp;
+}
+
+/*
+ * Parse a YFS-RxGK type XDR format token
+ * - the caller guarantees we have at least 4 words
+ *
+ * struct token_rxgk {
+ *	opr_time begintime;
+ *	opr_time endtime;
+ *	afs_int64 level;
+ *	afs_int64 lifetime;
+ *	afs_int64 bytelife;
+ *	afs_int64 enctype;
+ *	opaque key<>;
+ *	opaque ticket<>;
+ * };
+ */
+static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
+				       size_t datalen,
+				       const __be32 *xdr, unsigned int toklen)
+{
+	struct rxrpc_key_token *token, **pptoken;
+	time64_t expiry;
+	size_t plen;
+	const __be32 *ticket, *key;
+	s64 tmp;
+	u32 tktlen, keylen;
+
+	_enter(",{%x,%x,%x,%x},%x",
+	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
+	       toklen);
+
+	if (6 * 2 + 2 > toklen / 4)
+		goto reject;
+
+	key = xdr + (6 * 2 + 1);
+	keylen = ntohl(key[-1]);
+	_debug("keylen: %x", keylen);
+	keylen = round_up(keylen, 4);
+	if ((6 * 2 + 2) * 4 + keylen > toklen)
+		goto reject;
+
+	ticket = xdr + (6 * 2 + 1 + (keylen / 4) + 1);
+	tktlen = ntohl(ticket[-1]);
+	_debug("tktlen: %x", tktlen);
+	tktlen = round_up(tktlen, 4);
+	if ((6 * 2 + 2) * 4 + keylen + tktlen != toklen) {
+		kleave(" = -EKEYREJECTED [%x!=%x, %x,%x]",
+		       (6 * 2 + 2) * 4 + keylen + tktlen, toklen,
+		       keylen, tktlen);
+		goto reject;
+	}
+
+	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
+	prep->quotalen = datalen + plen;
+
+	plen -= sizeof(*token);
+	token = kzalloc(sizeof(*token), GFP_KERNEL);
+	if (!token)
+		goto nomem;
+
+	token->rxgk = kzalloc(sizeof(*token->rxgk) + keylen, GFP_KERNEL);
+	if (!token->rxgk)
+		goto nomem_token;
+
+	token->security_index	= RXRPC_SECURITY_YFS_RXGK;
+	token->rxgk->begintime	= xdr_dec64(xdr + 0 * 2);
+	token->rxgk->endtime	= xdr_dec64(xdr + 1 * 2);
+	token->rxgk->level	= tmp = xdr_dec64(xdr + 2 * 2);
+	if (tmp < -1LL || tmp > RXRPC_SECURITY_ENCRYPT)
+		goto reject_token;
+	token->rxgk->lifetime	= xdr_dec64(xdr + 3 * 2);
+	token->rxgk->bytelife	= xdr_dec64(xdr + 4 * 2);
+	token->rxgk->enctype	= tmp = xdr_dec64(xdr + 5 * 2);
+	if (tmp < 0 || tmp > UINT_MAX)
+		goto reject_token;
+	token->rxgk->key.len	= ntohl(key[-1]);
+	token->rxgk->key.data	= token->rxgk->_key;
+	token->rxgk->ticket.len = ntohl(ticket[-1]);
+
+	if (token->rxgk->endtime != 0) {
+		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
+		if (expiry < 0)
+			goto expired;
+		if (expiry < prep->expiry)
+			prep->expiry = expiry;
+	}
+
+	memcpy(token->rxgk->key.data, key, token->rxgk->key.len);
+
+	/* Pad the ticket so that we can use it directly in XDR */
+	token->rxgk->ticket.data = kzalloc(round_up(token->rxgk->ticket.len, 4),
+					   GFP_KERNEL);
+	if (!token->rxgk->ticket.data)
+		goto nomem_yrxgk;
+	memcpy(token->rxgk->ticket.data, ticket, token->rxgk->ticket.len);
+
+	_debug("SCIX: %u",	token->security_index);
+	_debug("EXPY: %llx",	token->rxgk->endtime);
+	_debug("LIFE: %llx",	token->rxgk->lifetime);
+	_debug("BYTE: %llx",	token->rxgk->bytelife);
+	_debug("ENC : %u",	token->rxgk->enctype);
+	_debug("LEVL: %u",	token->rxgk->level);
+	_debug("KLEN: %u",	token->rxgk->key.len);
+	_debug("TLEN: %u",	token->rxgk->ticket.len);
+	_debug("KEY0: %*phN",	token->rxgk->key.len, token->rxgk->key.data);
+	_debug("TICK: %*phN",
+	       min_t(u32, token->rxgk->ticket.len, 32), token->rxgk->ticket.data);
+
+	/* count the number of tokens attached */
+	prep->payload.data[1] = (void *)((unsigned long)prep->payload.data[1] + 1);
+
+	/* attach the data */
+	for (pptoken = (struct rxrpc_key_token **)&prep->payload.data[0];
+	     *pptoken;
+	     pptoken = &(*pptoken)->next)
+		continue;
+	*pptoken = token;
+
+	_leave(" = 0");
+	return 0;
+
+nomem_yrxgk:
+	kfree(token->rxgk);
+nomem_token:
+	kfree(token);
+nomem:
+	return -ENOMEM;
+reject_token:
+	kfree(token);
+reject:
+	return -EKEYREJECTED;
+expired:
+	kfree(token->rxgk);
+	kfree(token);
+	return -EKEYEXPIRED;
+}
+
 /*
  * attempt to parse the data as the XDR format
  * - the caller guarantees we have more than 7 words
@@ -228,6 +382,9 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 		case RXRPC_SECURITY_RXKAD:
 			ret2 = rxrpc_preparse_xdr_rxkad(prep, datalen, token, toklen);
 			break;
+		case RXRPC_SECURITY_YFS_RXGK:
+			ret2 = rxrpc_preparse_xdr_yfs_rxgk(prep, datalen, token, toklen);
+			break;
 		default:
 			ret2 = -EPROTONOSUPPORT;
 			break;
@@ -390,6 +547,10 @@ static void rxrpc_free_token_list(struct rxrpc_key_token *token)
 		case RXRPC_SECURITY_RXKAD:
 			kfree(token->kad);
 			break;
+		case RXRPC_SECURITY_YFS_RXGK:
+			kfree(token->rxgk->ticket.data);
+			kfree(token->rxgk);
+			break;
 		default:
 			pr_err("Unknown token type %x on rxrpc key\n",
 			       token->security_index);
@@ -433,6 +594,9 @@ static void rxrpc_describe(const struct key *key, struct seq_file *m)
 		case RXRPC_SECURITY_RXKAD:
 			seq_puts(m, "ka");
 			break;
+		case RXRPC_SECURITY_YFS_RXGK:
+			seq_puts(m, "ygk");
+			break;
 		default: /* we have a ticket we can't encode */
 			seq_printf(m, "%u", token->security_index);
 			break;
@@ -597,6 +761,13 @@ static long rxrpc_read(const struct key *key,
 				toksize += RND(token->kad->ticket_len);
 			break;
 
+		case RXRPC_SECURITY_YFS_RXGK:
+			toksize += 6 * 8 + 2 * 4;
+			if (!token->no_leak_key)
+				toksize += RND(token->rxgk->key.len);
+			toksize += RND(token->rxgk->ticket.len);
+			break;
+
 		default: /* we have a ticket we can't encode */
 			pr_err("Unsupported key token type (%u)\n",
 			       token->security_index);
@@ -676,6 +847,20 @@ static long rxrpc_read(const struct key *key,
 				ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
 			break;
 
+		case RXRPC_SECURITY_YFS_RXGK:
+			ENCODE64(token->rxgk->begintime);
+			ENCODE64(token->rxgk->endtime);
+			ENCODE64(token->rxgk->level);
+			ENCODE64(token->rxgk->lifetime);
+			ENCODE64(token->rxgk->bytelife);
+			ENCODE64(token->rxgk->enctype);
+			if (token->no_leak_key)
+				ENCODE(0);
+			else
+				ENCODE_DATA(token->rxgk->key.len, token->rxgk->key.data);
+			ENCODE_DATA(token->rxgk->ticket.len, token->rxgk->ticket.data);
+			break;
+
 		default:
 			pr_err("Unsupported key token type (%u)\n",
 			       token->security_index);


