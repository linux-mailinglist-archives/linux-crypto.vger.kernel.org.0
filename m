Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06C580B62
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Jul 2022 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiGZGTB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 Jul 2022 02:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiGZGSA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 26 Jul 2022 02:18:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2891CFFB;
        Mon, 25 Jul 2022 23:16:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf4so24385412ejc.3;
        Mon, 25 Jul 2022 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxZDYt1hGgQUAd0nelpqpJTBsvuXPYRfB91p7EEsvhI=;
        b=XtDKb3+4jyrMrR4uVhZNPTfQhIM20mar04gv7dzo9VMgE3P4eS21ANdqd9yzgv/iVm
         ZRnYa2pCfT/pGAs9n4fXXnkVpMYh8QjYjjhgGG2UYSZUIh3Wpg6mTsKOYiur6CcFGWVE
         8a9zv6dUd/fUDAw4zwVHX18xMOcDDPZCW14Q3eH9GfV1IPueKcFyCzKGBw5/rio3EoY+
         SaWJKpbGQBDaKkSxf2s1fo2BVCl2Sa6cPn+G/tnFuv1+3jLJGsa2cCDgXFwpUGPNsePN
         RnYmG5+HOhXBUfPvmk4xeIz0qVd7UiCkuH3G2HTXBshExMMxmDkORf/vxrnhOFoHGGuf
         HrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxZDYt1hGgQUAd0nelpqpJTBsvuXPYRfB91p7EEsvhI=;
        b=nvECzgsL09QH/N4hb+ZN4bTnUO4lKykH0ND6dv14A4LdzgKJOCzU65cw/2+0cSG8uQ
         1aKvdNJQ/ZHfM4mHqdAl812uCJ0/3tSZ52xSuLnno47m7t+5AOYE4wV+alrYSFpj5R0a
         485/JytAelve6mIm6bmcZJe4OhDTMtxLd4snEY+Ldv6+LtzygsqYPX4BDXaX4ukVUgLQ
         +GA8V+Sdo4dCLwLojIpE2A9QLzA8iHt1NAHMDdRWiXm4uVApC6xOOOosldYRH+15KZie
         XFYChdTz8qViSvzww6QJD+hyCJ+E/44yD5pS6e9LZfTs+LZZO9eJY6KzuBWZmRey6WTW
         FtVg==
X-Gm-Message-State: AJIora+bf+8djMovHYugMASyLgiSVtzIue8KWrdl7C689bpNeaWYsptG
        rYChNVSxaKiXKuX383kHOMQ=
X-Google-Smtp-Source: AGRyM1s5YH07B5Orh5fptYVWbgeLH9ge7z07D9YYgHaCOHNWlpjxXS7UgeSrDI/pzylPlJFI4JBfSA==
X-Received: by 2002:a17:906:c781:b0:726:c967:8d1b with SMTP id cw1-20020a170906c78100b00726c9678d1bmr12915583ejb.54.1658816164828;
        Mon, 25 Jul 2022 23:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:241e:502:a080:2b68:36a:5a94:4ba1])
        by smtp.gmail.com with ESMTPSA id l23-20020a056402345700b0043ba7df7a42sm8133067edc.26.2022.07.25.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 23:16:04 -0700 (PDT)
From:   Leonard Crestez <cdleonard@gmail.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Philip Paeps <philip@trouble.is>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Caowangbao <caowangbao@huawei.com>,
        Priyaranjan Jha <priyarjha@google.com>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/26] tcp: authopt: Add key selection controls
Date:   Tue, 26 Jul 2022 09:15:16 +0300
Message-Id: <31964bc352cf76efc3b21f3dcd5fa40db2129070.1658815925.git.cdleonard@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1658815925.git.cdleonard@gmail.com>
References: <cover.1658815925.git.cdleonard@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The RFC requires that TCP can report the keyid and rnextkeyid values
being sent or received, implement this via getsockopt values.

The RFC also requires that user can select the sending key and that the
sending key is automatically switched based on rnextkeyid. These
requirements can conflict so we implement both and add a flag which
specifies if user or peer request takes priority.

Also add an option to control rnextkeyid explicitly from userspace.

Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
---
 Documentation/networking/tcp_authopt.rst |  25 ++++++
 include/net/tcp_authopt.h                |  40 ++++++++-
 include/uapi/linux/tcp.h                 |  31 +++++++
 net/ipv4/tcp_authopt.c                   | 107 ++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                      |   2 +-
 net/ipv6/tcp_ipv6.c                      |   2 +-
 6 files changed, 200 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/tcp_authopt.rst b/Documentation/networking/tcp_authopt.rst
index 72adb7a891ce..f29fdea7769f 100644
--- a/Documentation/networking/tcp_authopt.rst
+++ b/Documentation/networking/tcp_authopt.rst
@@ -42,10 +42,35 @@ new flags.
 
 RFC5925 requires that key ids do not overlap when tcp identifiers (addr/port)
 overlap. This is not enforced by linux, configuring ambiguous keys will result
 in packet drops and lost connections.
 
+Key selection
+-------------
+
+On getsockopt(TCP_AUTHOPT) information is provided about keyid/rnextkeyid in
+the last send packet and about the keyid/rnextkeyd in the last valid received
+packet.
+
+By default the sending keyid is selected to match the rnextkeyid value sent by
+the remote side. If that keyid is not available (or for new connections) a
+random matching key is selected.
+
+If the ``TCP_AUTHOPT_LOCK_KEYID`` flag is set then the sending key is selected
+by the `tcp_authopt.send_local_id` field and recv_rnextkeyid is ignored. If no
+key with local_id == send_local_id is configured then a random matching key is
+selected.
+
+The current sending key is cached in the socket and will not change unless
+requested by remote rnextkeyid or by setsockopt.
+
+The rnextkeyid value sent on the wire is usually the recv_id of the current
+key used for sending. If the TCP_AUTHOPT_LOCK_RNEXTKEY flag is set in
+`tcp_authopt.flags` the value of `tcp_authopt.send_rnextkeyid` is send
+instead.  This can be used to implement smooth rollover: the peer will switch
+its keyid to the received rnextkeyid when it is available.
+
 ABI Reference
 =============
 
 .. kernel-doc:: include/uapi/linux/tcp.h
    :identifiers: tcp_authopt tcp_authopt_flag tcp_authopt_key tcp_authopt_key_flag tcp_authopt_alg
diff --git a/include/net/tcp_authopt.h b/include/net/tcp_authopt.h
index 9bc0f58a78cb..6b4329a18a1f 100644
--- a/include/net/tcp_authopt.h
+++ b/include/net/tcp_authopt.h
@@ -70,10 +70,45 @@ struct tcp_authopt_info {
 	u32 dst_isn;
 	/** @rcv_sne: Recv-side Sequence Number Extension tracking tcp_sock.rcv_nxt */
 	u32 rcv_sne;
 	/** @snd_sne: Send-side Sequence Number Extension tracking tcp_sock.snd_nxt */
 	u32 snd_sne;
+
+	/**
+	 * @send_keyid: keyid currently being sent
+	 *
+	 * This is controlled by userspace by userspace if
+	 * TCP_AUTHOPT_FLAG_LOCK_KEYID, otherwise we try to match recv_rnextkeyid
+	 */
+	u8 send_keyid;
+	/**
+	 * @send_rnextkeyid: rnextkeyid currently being sent
+	 *
+	 * This is controlled by userspace if TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID is set
+	 */
+	u8 send_rnextkeyid;
+	/**
+	 * @recv_keyid: last keyid received from remote
+	 *
+	 * This is reported to userspace but has no other special behavior attached.
+	 */
+	u8 recv_keyid;
+	/**
+	 * @recv_rnextkeyid: last rnextkeyid received from remote
+	 *
+	 * Linux tries to honor this unless TCP_AUTHOPT_FLAG_LOCK_KEYID is set
+	 */
+	u8 recv_rnextkeyid;
+
+	/**
+	 * @send_key: Current key used for sending, cached.
+	 *
+	 * Once a key is found it only changes by user or remote request.
+	 *
+	 * Field is protected by the socket lock and holds a kref to the key.
+	 */
+	struct tcp_authopt_key_info __rcu *send_key;
 };
 
 /* TCP authopt as found in header */
 struct tcphdr_authopt {
 	u8 num;
@@ -94,22 +129,23 @@ int tcp_get_authopt_val(struct sock *sk, struct tcp_authopt *key);
 int tcp_set_authopt_key(struct sock *sk, sockptr_t optval, unsigned int optlen);
 struct tcp_authopt_key_info *__tcp_authopt_select_key(
 		const struct sock *sk,
 		struct tcp_authopt_info *info,
 		const struct sock *addr_sk,
-		u8 *rnextkeyid);
+		u8 *rnextkeyid,
+		bool locked);
 static inline struct tcp_authopt_key_info *tcp_authopt_select_key(
 		const struct sock *sk,
 		const struct sock *addr_sk,
 		struct tcp_authopt_info **info,
 		u8 *rnextkeyid)
 {
 	if (tcp_authopt_needed) {
 		*info = rcu_dereference(tcp_sk(sk)->authopt_info);
 
 		if (*info)
-			return __tcp_authopt_select_key(sk, *info, addr_sk, rnextkeyid);
+			return __tcp_authopt_select_key(sk, *info, addr_sk, rnextkeyid, true);
 	}
 	return NULL;
 }
 int tcp_authopt_hash(
 		char *hash_location,
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 76d7be6b27f4..e02176390519 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -346,10 +346,24 @@ struct tcp_diag_md5sig {
 
 /**
  * enum tcp_authopt_flag - flags for `tcp_authopt.flags`
  */
 enum tcp_authopt_flag {
+	/**
+	 * @TCP_AUTHOPT_FLAG_LOCK_KEYID: keyid controlled by sockopt
+	 *
+	 * If this is set `tcp_authopt.send_keyid` is used to determined sending
+	 * key. Otherwise a key with send_id == recv_rnextkeyid is preferred.
+	 */
+	TCP_AUTHOPT_FLAG_LOCK_KEYID = (1 << 0),
+	/**
+	 * @TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID: Override rnextkeyid from userspace
+	 *
+	 * If this is set then `tcp_authopt.send_rnextkeyid` is sent on outbound
+	 * packets. Other the recv_id of the current sending key is sent.
+	 */
+	TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID = (1 << 1),
 	/**
 	 * @TCP_AUTHOPT_FLAG_REJECT_UNEXPECTED:
 	 *	Configure behavior of segments with TCP-AO coming from hosts for which no
 	 *	key is configured. The default recommended by RFC is to silently accept
 	 *	such connections.
@@ -361,10 +375,27 @@ enum tcp_authopt_flag {
  * struct tcp_authopt - Per-socket options related to TCP Authentication Option
  */
 struct tcp_authopt {
 	/** @flags: Combination of &enum tcp_authopt_flag */
 	__u32	flags;
+	/**
+	 * @send_keyid: `tcp_authopt_key.send_id` of preferred send key
+	 *
+	 * This is only used if `TCP_AUTHOPT_FLAG_LOCK_KEYID` is set.
+	 */
+	__u8	send_keyid;
+	/**
+	 * @send_rnextkeyid: The rnextkeyid to send in packets
+	 *
+	 * This is controlled by the user iff TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID is
+	 * set. Otherwise rnextkeyid is the recv_id of the current key.
+	 */
+	__u8	send_rnextkeyid;
+	/** @recv_keyid: A recently-received keyid value. Only for getsockopt. */
+	__u8	recv_keyid;
+	/** @recv_rnextkeyid: A recently-received rnextkeyid value. Only for getsockopt. */
+	__u8	recv_rnextkeyid;
 };
 
 /**
  * enum tcp_authopt_key_flag - flags for `tcp_authopt.flags`
  *
diff --git a/net/ipv4/tcp_authopt.c b/net/ipv4/tcp_authopt.c
index f7635a37b972..c4c7a9a0057d 100644
--- a/net/ipv4/tcp_authopt.c
+++ b/net/ipv4/tcp_authopt.c
@@ -372,22 +372,89 @@ static struct tcp_authopt_key_info *tcp_authopt_lookup_send(struct netns_tcp_aut
  *
  * @sk: socket
  * @info: socket's tcp_authopt_info
  * @addr_sk: socket used for address lookup. Same as sk except for synack case
  * @rnextkeyid: value of rnextkeyid caller should write in packet
+ * @locked: If we're holding the socket lock. This is false for some timewait and reset cases
  *
  * Result is protected by RCU and can't be stored, it may only be passed to
  * tcp_authopt_hash and only under a single rcu_read_lock.
  */
 struct tcp_authopt_key_info *__tcp_authopt_select_key(const struct sock *sk,
 						      struct tcp_authopt_info *info,
 						      const struct sock *addr_sk,
-						      u8 *rnextkeyid)
+						      u8 *rnextkeyid,
+						      bool locked)
 {
+	struct tcp_authopt_key_info *key, *new_key = NULL;
 	struct netns_tcp_authopt *net = sock_net_tcp_authopt(sk);
 
-	return tcp_authopt_lookup_send(net, addr_sk, -1);
+	/* Listen sockets don't refer to any specific connection so we don't try
+	 * to keep using the same key and ignore any received keyids.
+	 */
+	if (sk->sk_state == TCP_LISTEN) {
+		int send_keyid = -1;
+
+		if (info->flags & TCP_AUTHOPT_FLAG_LOCK_KEYID)
+			send_keyid = info->send_keyid;
+		key = tcp_authopt_lookup_send(net, addr_sk, send_keyid);
+		if (key)
+			*rnextkeyid = key->recv_id;
+
+		return key;
+	}
+
+	if (locked) {
+		sock_owned_by_me(sk);
+		key = rcu_dereference_protected(info->send_key, lockdep_sock_is_held(sk));
+		if (key && (key->flags & TCP_AUTHOPT_KEY_DEL) == TCP_AUTHOPT_KEY_DEL) {
+			info->send_key = NULL;
+			tcp_authopt_key_put(key);
+			key = NULL;
+		}
+	} else {
+		key = NULL;
+	}
+
+	/* Try to keep the same sending key unless user or peer requires a different key
+	 * User request (via TCP_AUTHOPT_FLAG_LOCK_KEYID) always overrides peer request.
+	 */
+	if (info->flags & TCP_AUTHOPT_FLAG_LOCK_KEYID) {
+		int send_keyid = info->send_keyid;
+
+		if (!key || key->send_id != send_keyid)
+			new_key = tcp_authopt_lookup_send(net, addr_sk, send_keyid);
+	} else {
+		if (!key || key->send_id != info->recv_rnextkeyid)
+			new_key = tcp_authopt_lookup_send(net, addr_sk, info->recv_rnextkeyid);
+	}
+	/* If no key found with specific send_id try anything else. */
+	if (!key && !new_key)
+		new_key = tcp_authopt_lookup_send(net, addr_sk, -1);
+
+	/* Update current key only if we hold the socket lock. */
+	if (new_key && key != new_key) {
+		if (locked) {
+			if (kref_get_unless_zero(&new_key->ref)) {
+				rcu_assign_pointer(info->send_key, new_key);
+				tcp_authopt_key_put(key);
+			}
+			/* If key was deleted it's still valid until the end of
+			 * the RCU grace period.
+			 */
+		}
+		key = new_key;
+	}
+
+	if (key) {
+		if (info->flags & TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID)
+			*rnextkeyid = info->send_rnextkeyid;
+		else
+			*rnextkeyid = info->send_rnextkeyid = key->recv_id;
+	}
+
+	return key;
 }
 EXPORT_SYMBOL(__tcp_authopt_select_key);
 
 static struct tcp_authopt_info *__tcp_authopt_info_get_or_create(struct sock *sk)
 {
@@ -409,10 +476,12 @@ static struct tcp_authopt_info *__tcp_authopt_info_get_or_create(struct sock *sk
 
 	return info;
 }
 
 #define TCP_AUTHOPT_KNOWN_FLAGS ( \
+	TCP_AUTHOPT_FLAG_LOCK_KEYID | \
+	TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID | \
 	TCP_AUTHOPT_FLAG_REJECT_UNEXPECTED)
 
 /* Like copy_from_sockptr except tolerate different optlen for compatibility reasons
  *
  * If the src is shorter then it's from an old userspace and the rest of dst is
@@ -480,18 +549,23 @@ int tcp_set_authopt(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	info = __tcp_authopt_info_get_or_create(sk);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	info->flags = opt.flags & TCP_AUTHOPT_KNOWN_FLAGS;
+	if (opt.flags & TCP_AUTHOPT_FLAG_LOCK_KEYID)
+		info->send_keyid = opt.send_keyid;
+	if (opt.flags & TCP_AUTHOPT_FLAG_LOCK_RNEXTKEYID)
+		info->send_rnextkeyid = opt.send_rnextkeyid;
 
 	return 0;
 }
 
 int tcp_get_authopt_val(struct sock *sk, struct tcp_authopt *opt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_authopt_info *info;
+	struct tcp_authopt_key_info *send_key;
 	int err;
 
 	memset(opt, 0, sizeof(*opt));
 	sock_owned_by_me(sk);
 	err = check_sysctl_tcp_authopt();
@@ -501,10 +575,22 @@ int tcp_get_authopt_val(struct sock *sk, struct tcp_authopt *opt)
 	info = rcu_dereference_check(tp->authopt_info, lockdep_sock_is_held(sk));
 	if (!info)
 		return -ENOENT;
 
 	opt->flags = info->flags & TCP_AUTHOPT_KNOWN_FLAGS;
+	/* These keyids might be undefined, for example before connect.
+	 * Reporting zero is not strictly correct because there are no reserved
+	 * values.
+	 */
+	send_key = rcu_dereference_check(info->send_key, lockdep_sock_is_held(sk));
+	if (send_key)
+		opt->send_keyid = send_key->send_id;
+	else
+		opt->send_keyid = 0;
+	opt->send_rnextkeyid = info->send_rnextkeyid;
+	opt->recv_keyid = info->recv_keyid;
+	opt->recv_rnextkeyid = info->recv_rnextkeyid;
 
 	return 0;
 }
 
 #define TCP_AUTHOPT_KEY_KNOWN_FLAGS ( \
@@ -1465,11 +1551,11 @@ int __tcp_authopt_inbound_check(struct sock *sk, struct sk_buff *skb,
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTHOPTFAILURE);
 			print_tcpao_notice("TCP Authentication Unexpected: Rejected", skb);
 			return -SKB_DROP_REASON_TCP_AOUNEXPECTED;
 		}
 		print_tcpao_notice("TCP Authentication Unexpected: Accepted", skb);
-		return 0;
+		goto accept;
 	}
 	if (opt && !key) {
 		/* Keys are configured for peer but with different keyid than packet */
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTHOPTFAILURE);
 		print_tcpao_notice("TCP Authentication Failed", skb);
@@ -1488,10 +1574,25 @@ int __tcp_authopt_inbound_check(struct sock *sk, struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTHOPTFAILURE);
 		print_tcpao_notice("TCP Authentication Failed", skb);
 		return -SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
+accept:
+	/* Doing this for all valid packets will results in keyids temporarily
+	 * flipping back and forth if packets are reordered or retransmitted
+	 * but keys should eventually stabilize.
+	 *
+	 * This is connection-specific so don't store for listen sockets.
+	 *
+	 * We could store rnextkeyid from SYN in a request sock and use it for
+	 * the SYNACK but we don't.
+	 */
+	if (sk->sk_state != TCP_LISTEN) {
+		info->recv_keyid = opt->keyid;
+		info->recv_rnextkeyid = opt->rnextkeyid;
+	}
+
 	return 1;
 }
 EXPORT_SYMBOL(__tcp_authopt_inbound_check);
 
 static int tcp_authopt_init_net(struct net *full_net)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0f76a03c007a..fe244703b91a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -665,11 +665,11 @@ static int tcp_v4_authopt_handle_reply(const struct sock *sk,
 		info = tcp_twsk(sk)->tw_authopt_info;
 	else
 		info = rcu_dereference_check(tcp_sk(sk)->authopt_info, lockdep_sock_is_held(sk));
 	if (!info)
 		return 0;
-	key_info = __tcp_authopt_select_key(sk, info, sk, &rnextkeyid);
+	key_info = __tcp_authopt_select_key(sk, info, sk, &rnextkeyid, false);
 	if (!key_info)
 		return 0;
 	*optptr = htonl((TCPOPT_AUTHOPT << 24) |
 			(TCPOLEN_AUTHOPT_OUTPUT << 16) |
 			(key_info->send_id << 8) |
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 63fdbb181bb8..ebe2aa48b7a9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -852,11 +852,11 @@ static int tcp_v6_send_response_init_authopt(const struct sock *sk,
 		*info = tcp_twsk(sk)->tw_authopt_info;
 	else
 		*info = rcu_dereference(tcp_sk(sk)->authopt_info);
 	if (!*info)
 		return 0;
-	*key = __tcp_authopt_select_key(sk, *info, sk, rnextkeyid);
+	*key = __tcp_authopt_select_key(sk, *info, sk, rnextkeyid, false);
 	if (*key)
 		return TCPOLEN_AUTHOPT_OUTPUT;
 	return 0;
 }
 
-- 
2.25.1

