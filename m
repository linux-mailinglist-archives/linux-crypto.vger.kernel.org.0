Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC43CE23D
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jul 2021 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbhGSP3h (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Jul 2021 11:29:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35546 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347756AbhGSPUj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Jul 2021 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1626710480; x=1658246480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uaa+9IHlkakLivclHv7pranwhZxaxEm4Ly5vzcPZ1NI=;
  b=rzcWBMBGrAfZHjBP2tq9CPrGBUdRMe/xETa85+qmNV4h+nGTVkgnjB0w
   9S6WtXTywRMQiYETrEksqbOxOfwezMedRa8Rk13mXIRVJ31RO99y0aXcS
   Jcx7aM9AmFfBzaXko+Pn81MMw/NPrOIDFvyuzmRa5vR+NynzVfpn0i2uu
   U=;
X-IronPort-AV: E=Sophos;i="5.84,252,1620691200"; 
   d="scan'208";a="127822409"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 19 Jul 2021 16:01:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 1FDCAA1CDB;
        Mon, 19 Jul 2021 16:01:10 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 19 Jul 2021 16:01:08 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.55) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 19 Jul 2021 16:00:55 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <cdleonard@gmail.com>
CC:     <colona@arista.com>, <cpaasch@apple.com>, <davem@davemloft.net>,
        <dong.menglong@zte.com.cn>, <dsahern@kernel.org>,
        <edumazet@google.com>, <herbert@gondor.apana.org.au>,
        <kuba@kernel.org>, <kuniyu@amazon.co.jp>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mathew.j.martineau@linux.intel.com>, <netdev@vger.kernel.org>,
        <priyarjha@google.com>, <ycheng@google.com>,
        <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] tcp: Initial support for RFC5925 auth option
Date:   Tue, 20 Jul 2021 01:00:51 +0900
Message-ID: <20210719160051.59046-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <01383a8751e97ef826ef2adf93bfde3a08195a43.1626693859.git.cdleonard@gmail.com>
References: <01383a8751e97ef826ef2adf93bfde3a08195a43.1626693859.git.cdleonard@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.55]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From:   Leonard Crestez <cdleonard@gmail.com>
Date:   Mon, 19 Jul 2021 14:24:46 +0300
> This is similar to TCP MD5 in functionality but it's sufficiently
> different that userspace interface and wire formats are incompatible.
> Compared to TCP-MD5 more algorithms are supported and multiple keys can
> be used on the same connection but there is still no negotiation
> mechanism.
> 
> Expected use-case is protecting long-duration BGP/LDP connections
> between routers using pre-shared keys.
> 
> This is an early version which focuses on getting the correct
> signature bits on the wire in a way that can interoperate with other
> implementations. Major issues still need to be solved:
> 
>  * Lockdep warnings (incorrect context for initializing shash)
>  * Support for aes-128-cmac-96
>  * Binding keys to addresses and/or interfaces similar to md5
>  * Sequence Number Extension
> 
> A small test suite is here: https://github.com/cdleonard/tcp-authopt-test
> The tests work by establishing loopback TCP connections, capturing
> packets with scapy and validating signatures.
> 
> Changes for yabgp are here:
> https://github.com/cdleonard/yabgp/commits/tcp_authopt
> The patched version of yabgp can establish a BGP session protected by
> TCP Authentication Option with a Cisco IOS-XR router.
> 
> I'm especially interested in feedback regarding ABI and testing.
> 
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> 
> ---
> 
> Allocating shash requires user context but holding a struct tfm in
> tcp_authopt_key_info allocated by tcp_set_authopt_key doesn't work
> because when a server handshake is succesful the server socket needs to
> copy the keys of the listen socket in softirq context.
> 
> Sharing the crypto_shash tfm between listen and server sockets doesn't
> work well either because keys for each connection (and each syn packet)
> are different and the hmac or cmac key is per-tfm rather than per
> shash_desc. The server sockets would need locking to access their shared
> tfm.
> 
> Simplest solution would be to allocate one shash for each CPU and borrow
> it for each hashing operation. TCP-MD5 allocates one ahash globally but
> that can't work for hmac/cmac because of setkey.
> 
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> ---
>  include/linux/tcp.h       |   6 +
>  include/net/tcp.h         |   1 +
>  include/net/tcp_authopt.h | 103 ++++++
>  include/uapi/linux/snmp.h |   1 +
>  include/uapi/linux/tcp.h  |  40 +++
>  net/ipv4/Kconfig          |  14 +
>  net/ipv4/Makefile         |   1 +
>  net/ipv4/proc.c           |   1 +
>  net/ipv4/tcp.c            |   7 +
>  net/ipv4/tcp_authopt.c    | 718 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_input.c      |  17 +
>  net/ipv4/tcp_ipv4.c       |   5 +
>  net/ipv4/tcp_minisocks.c  |   2 +
>  net/ipv4/tcp_output.c     |  65 +++-
>  14 files changed, 980 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/tcp_authopt.h
>  create mode 100644 net/ipv4/tcp_authopt.c
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 48d8a363319e..cfddfc720b00 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -140,10 +140,12 @@ struct tcp_request_sock {
>  static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
>  {
>  	return (struct tcp_request_sock *)req;
>  }
>  
> +struct tcp_authopt_info;
> +
>  struct tcp_sock {
>  	/* inet_connection_sock has to be the first member of tcp_sock */
>  	struct inet_connection_sock	inet_conn;
>  	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
>  	u16	gso_segs;	/* Max number of segs per GSO packet	*/
> @@ -403,10 +405,14 @@ struct tcp_sock {
>  
>  /* TCP MD5 Signature Option information */
>  	struct tcp_md5sig_info	__rcu *md5sig_info;
>  #endif
>  
> +#ifdef CONFIG_TCP_AUTHOPT
> +	struct tcp_authopt_info	__rcu *authopt_info;
> +#endif
> +
>  /* TCP fastopen related information */
>  	struct tcp_fastopen_request *fastopen_req;
>  	/* fastopen_rsk points to request_sock that resulted in this big
>  	 * socket. Used to retransmit SYNACKs etc.
>  	 */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 17df9b047ee4..767611fd5ec3 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -182,10 +182,11 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
>  #define TCPOPT_WINDOW		3	/* Window scaling */
>  #define TCPOPT_SACK_PERM        4       /* SACK Permitted */
>  #define TCPOPT_SACK             5       /* SACK Block */
>  #define TCPOPT_TIMESTAMP	8	/* Better RTT estimations/PAWS */
>  #define TCPOPT_MD5SIG		19	/* MD5 Signature (RFC2385) */
> +#define TCPOPT_AUTHOPT		29	/* Auth Option (RFC5925) */
>  #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
>  #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
>  #define TCPOPT_EXP		254	/* Experimental */
>  /* Magic number to be after the option value for sharing TCP
>   * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
> diff --git a/include/net/tcp_authopt.h b/include/net/tcp_authopt.h
> new file mode 100644
> index 000000000000..aaab5c955984
> --- /dev/null
> +++ b/include/net/tcp_authopt.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _LINUX_TCP_AUTHOPT_H
> +#define _LINUX_TCP_AUTHOPT_H
> +
> +#include <uapi/linux/tcp.h>
> +
> +/* Representation of a Master Key Tuple as per RFC5925 */
> +struct tcp_authopt_key_info {
> +	struct hlist_node node;
> +	/* Local identifier */
> +	u32 local_id;
> +	u32 flags;
> +	/* Wire identifiers */
> +	u8 send_id, recv_id;
> +	u8 alg;
> +	u8 keylen;
> +	u8 key[TCP_AUTHOPT_MAXKEYLEN];
> +	u8 maclen;
> +	u8 traffic_key_len;
> +	struct rcu_head rcu;
> +};
> +
> +/* Per-socket information regarding tcp_authopt */
> +struct tcp_authopt_info {
> +	struct hlist_head head;
> +	u32 local_send_id;
> +	u32 src_isn;
> +	u32 dst_isn;
> +	u8 rnextkeyid;
> +	struct rcu_head rcu;
> +};
> +
> +#ifdef CONFIG_TCP_AUTHOPT
> +struct tcp_authopt_key_info *tcp_authopt_key_info_lookup(struct sock *sk, int key_id);
> +void tcp_authopt_clear(struct sock *sk);
> +int tcp_set_authopt(struct sock *sk, sockptr_t optval, unsigned int optlen);
> +int tcp_set_authopt_key(struct sock *sk, sockptr_t optval, unsigned int optlen);
> +int tcp_authopt_hash(
> +		char *hash_location,
> +		struct tcp_authopt_key_info *key,
> +		struct sock *sk, struct sk_buff *skb);
> +int __tcp_authopt_openreq(struct sock *newsk, const struct sock *oldsk, struct request_sock *req);
> +static inline int tcp_authopt_openreq(
> +		struct sock *newsk,
> +		const struct sock *oldsk,
> +		struct request_sock *req)
> +{
> +	if (!rcu_dereference(tcp_sk(oldsk)->authopt_info))

s/rcu_dereference/rcu_access_pointer/


> +		return 0;
> +	else
> +		return __tcp_authopt_openreq(newsk, oldsk, req);

nit: 'else' can be removed.


> +}
> +int __tcp_authopt_inbound_check(
> +		struct sock *sk,
> +		struct sk_buff *skb,
> +		struct tcp_authopt_info *info);
> +static inline int tcp_authopt_inbound_check(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tcp_authopt_info *info = rcu_dereference(tcp_sk(sk)->authopt_info);
> +
> +	if (info)
> +		return __tcp_authopt_inbound_check(sk, skb, info);
> +	else
> +		return 0;

Same with the above and can be formatted like:

	if (!info)
		return 0;

	return __tcp_authopt_inbound_check(sk, skb, info);


> +}
> +#else
> +static inline struct tcp_authopt_key_info *tcp_authopt_key_info_lookup(
> +		struct sock *sk,
> +		int key_id)
> +{
> +	return NULL;
> +}
> +static inline int tcp_set_authopt(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	return -ENOPROTOOPT;
> +}
> +static inline void tcp_authopt_clear(struct sock *sk)
> +{
> +}
> +static inline int tcp_set_authopt_key(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	return -ENOPROTOOPT;
> +}
> +static inline int tcp_authopt_hash(
> +		char *hash_location,
> +		struct tcp_authopt_key_info *key,
> +		struct sock *sk, struct sk_buff *skb)
> +{
> +	return -EINVAL;
> +}
> +static inline int tcp_authopt_openreq(struct sock *newsk,
> +				      const struct sock *oldsk,
> +				      struct request_sock *req)
> +{
> +	return 0;
> +}
> +static inline int tcp_authopt_inbound_check(struct sock *sk, struct sk_buff *skb)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* _LINUX_TCP_AUTHOPT_H */
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 904909d020e2..1d96030889a1 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -290,10 +290,11 @@ enum
>  	LINUX_MIB_TCPDUPLICATEDATAREHASH,	/* TCPDuplicateDataRehash */
>  	LINUX_MIB_TCPDSACKRECVSEGS,		/* TCPDSACKRecvSegs */
>  	LINUX_MIB_TCPDSACKIGNOREDDUBIOUS,	/* TCPDSACKIgnoredDubious */
>  	LINUX_MIB_TCPMIGRATEREQSUCCESS,		/* TCPMigrateReqSuccess */
>  	LINUX_MIB_TCPMIGRATEREQFAILURE,		/* TCPMigrateReqFailure */
> +	LINUX_MIB_TCPAUTHOPTFAILURE,		/* TCPAuthOptFailure */
>  	__LINUX_MIB_MAX
>  };
>  
>  /* linux Xfrm mib definitions */
>  enum
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 8fc09e8638b3..30b8ad769871 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -126,10 +126,12 @@ enum {
>  #define TCP_INQ			36	/* Notify bytes available to read as a cmsg on read */
>  
>  #define TCP_CM_INQ		TCP_INQ
>  
>  #define TCP_TX_DELAY		37	/* delay outgoing packets by XX usec */
> +#define TCP_AUTHOPT			38	/* TCP Authentication Option (RFC2385) */
> +#define TCP_AUTHOPT_KEY		39	/* TCP Authentication Option update key (RFC2385) */
>  
>  
>  #define TCP_REPAIR_ON		1
>  #define TCP_REPAIR_OFF		0
>  #define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
> @@ -340,10 +342,48 @@ struct tcp_diag_md5sig {
>  	__u16	tcpm_keylen;
>  	__be32	tcpm_addr[4];
>  	__u8	tcpm_key[TCP_MD5SIG_MAXKEYLEN];
>  };
>  
> +/* for TCP_AUTHOPT socket option */
> +#define TCP_AUTHOPT_MAXKEYLEN	80
> +
> +#define TCP_AUTHOPT_ALG_HMAC_SHA_1_96		1
> +#define TCP_AUTHOPT_ALG_AES_128_CMAC_96		2
> +
> +/* Per-socket options */
> +struct tcp_authopt {
> +	/* No flags currently defined */
> +	__u32	flags;
> +	/* local_id of preferred output key */
> +	__u32	local_send_id;
> +};
> +
> +/* Delete the key by local_id and ignore all fields */
> +#define TCP_AUTHOPT_KEY_DEL		(1 << 0)
> +/* Exclude TCP options from signature */
> +#define TCP_AUTHOPT_KEY_EXCLUDE_OPTS	(1 << 1)
> +
> +/* Per-key options
> + * Each key is identified by a non-zero local_id which is managed by the application.
> + */
> +struct tcp_authopt_key {
> +	/* Mix of TCP_AUTHOPT_KEY_ flags */
> +	__u32	flags;
> +	/* Local identifier */
> +	__u32	local_id;
> +	/* SendID on the network */
> +	__u8	send_id;
> +	/* RecvID on the network */
> +	__u8	recv_id;
> +	/* One of the TCP_AUTHOPT_ALG_* constant */
> +	__u8	alg;
> +	/* Length of the key buffer */
> +	__u8	keylen;
> +	__u8	key[TCP_AUTHOPT_MAXKEYLEN];
> +};
> +
>  /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
>  
>  #define TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT 0x1
>  struct tcp_zerocopy_receive {
>  	__u64 address;		/* in: address of mapping */
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 87983e70f03f..6459f4ea6f1d 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -740,5 +740,19 @@ config TCP_MD5SIG
>  	  RFC2385 specifies a method of giving MD5 protection to TCP sessions.
>  	  Its main (only?) use is to protect BGP sessions between core routers
>  	  on the Internet.
>  
>  	  If unsure, say N.
> +
> +config TCP_AUTHOPT
> +	bool "TCP: Authentication Option support (RFC5925)"
> +	select CRYPTO
> +	select CRYPTO_SHA1
> +	select CRYPTO_HMAC
> +	select CRYPTO_AES
> +	select CRYPTO_CMAC
> +	help
> +	  RFC5925 specifies a new method of giving protection to TCP sessions.
> +	  Its intended use is to protect BGP sessions between core routers
> +	  on the Internet. It obsoletes TCP MD5 (RFC2385) but is incompatible.
> +
> +	  If unsure, say N.
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index bbdd9c44f14e..d336f32ce177 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -59,10 +59,11 @@ obj-$(CONFIG_TCP_CONG_NV) += tcp_nv.o
>  obj-$(CONFIG_TCP_CONG_VENO) += tcp_veno.o
>  obj-$(CONFIG_TCP_CONG_SCALABLE) += tcp_scalable.o
>  obj-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
>  obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
>  obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
> +obj-$(CONFIG_TCP_AUTHOPT) += tcp_authopt.o
>  obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
>  obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
>  obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
>  
>  obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index b0d3a09dc84e..61dd06f8389c 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -295,10 +295,11 @@ static const struct snmp_mib snmp4_net_list[] = {
>  	SNMP_MIB_ITEM("TcpDuplicateDataRehash", LINUX_MIB_TCPDUPLICATEDATAREHASH),
>  	SNMP_MIB_ITEM("TCPDSACKRecvSegs", LINUX_MIB_TCPDSACKRECVSEGS),
>  	SNMP_MIB_ITEM("TCPDSACKIgnoredDubious", LINUX_MIB_TCPDSACKIGNOREDDUBIOUS),
>  	SNMP_MIB_ITEM("TCPMigrateReqSuccess", LINUX_MIB_TCPMIGRATEREQSUCCESS),
>  	SNMP_MIB_ITEM("TCPMigrateReqFailure", LINUX_MIB_TCPMIGRATEREQFAILURE),
> +	SNMP_MIB_ITEM("TCPAuthOptFailure", LINUX_MIB_TCPAUTHOPTFAILURE),
>  	SNMP_MIB_SENTINEL
>  };
>  
>  static void icmpmsg_put_line(struct seq_file *seq, unsigned long *vals,
>  			     unsigned short *type, int count)
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8cb44040ec68..3c29bb579d27 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -271,10 +271,11 @@
>  
>  #include <net/icmp.h>
>  #include <net/inet_common.h>
>  #include <net/tcp.h>
>  #include <net/mptcp.h>
> +#include <net/tcp_authopt.h>
>  #include <net/xfrm.h>
>  #include <net/ip.h>
>  #include <net/sock.h>
>  
>  #include <linux/uaccess.h>
> @@ -3573,10 +3574,16 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>  	case TCP_MD5SIG:
>  	case TCP_MD5SIG_EXT:
>  		err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
>  		break;
>  #endif
> +	case TCP_AUTHOPT:
> +		err = tcp_set_authopt(sk, optval, optlen);
> +		break;
> +	case TCP_AUTHOPT_KEY:
> +		err = tcp_set_authopt_key(sk, optval, optlen);
> +		break;
>  	case TCP_USER_TIMEOUT:
>  		/* Cap the max time in ms TCP will retry or probe the window
>  		 * before giving up and aborting (ETIMEDOUT) a connection.
>  		 */
>  		if (val < 0)
> diff --git a/net/ipv4/tcp_authopt.c b/net/ipv4/tcp_authopt.c
> new file mode 100644
> index 000000000000..40ee83fc0afe
> --- /dev/null
> +++ b/net/ipv4/tcp_authopt.c
> @@ -0,0 +1,718 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/kernel.h>
> +#include <net/tcp.h>
> +#include <net/tcp_authopt.h>
> +#include <crypto/hash.h>
> +#include <trace/events/tcp.h>
> +
> +/* All current algorithms have a mac length of 12 but crypto API digestsize can be larger */
> +#define TCP_AUTHOPT_MAXMACBUF	20
> +#define TCP_AUTHOPT_MAX_TRAFFIC_KEY_LEN	20
> +
> +struct tcp_authopt_key_info *__tcp_authopt_key_info_lookup(struct sock *sk,
> +							   struct tcp_authopt_info *info,
> +							   int key_id)
> +{
> +	struct tcp_authopt_key_info *key;
> +
> +	hlist_for_each_entry_rcu(key, &info->head, node, lockdep_sock_is_held(sk))
> +		if (key->local_id == key_id)
> +			return key;
> +
> +	return NULL;
> +}
> +
> +struct tcp_authopt_key_info *tcp_authopt_key_info_lookup(struct sock *sk, int key_id)
> +{
> +	struct tcp_authopt_info *info;
> +	struct tcp_authopt_key_info *key;
> +
> +	info = rcu_dereference_check(tcp_sk(sk)->authopt_info, lockdep_sock_is_held(sk));
> +	if (!info)
> +		return NULL;
> +
> +	hlist_for_each_entry_rcu(key, &info->head, node, lockdep_sock_is_held(sk))
> +		if (key->local_id == key_id)
> +			return key;
> +
> +	return NULL;

The loop and 'return' can be replaced by

	return __tcp_authopt_key_info_lookup(sk, info, key_id);


> +}
> +
> +int tcp_set_authopt(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct tcp_authopt opt;
> +	struct tcp_authopt_info *info;
> +
> +	if (optlen < sizeof(opt))
> +		return -EINVAL;
> +
> +	WARN_ON(!lockdep_sock_is_held(sk));
> +	if (copy_from_sockptr(&opt, optval, sizeof(opt)))
> +		return -EFAULT;
> +
> +	info = rcu_dereference_check(tp->authopt_info, lockdep_sock_is_held(sk));
> +	if (!info) {
> +		info = kmalloc(sizeof(*info), GFP_KERNEL | __GFP_ZERO);
> +		if (!info)
> +			return -ENOMEM;
> +
> +		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> +		INIT_HLIST_HEAD(&info->head);
> +		rcu_assign_pointer(tp->authopt_info, info);
> +	}

	info->flags = opt.flags;

In case we forget to add this in the future.


> +	info->local_send_id = opt.local_send_id;
> +
> +	return 0;
> +}
> +
> +static void tcp_authopt_key_del(struct sock *sk, struct tcp_authopt_key_info *key)
> +{
> +	hlist_del_rcu(&key->node);
> +	atomic_sub(sizeof(*key), &sk->sk_omem_alloc);

Should this be done after actually freeing the key?


> +	kfree_rcu(key, rcu);
> +}
> +
> +/* free info and keys but don't touch tp->authopt_info */
> +void __tcp_authopt_info_free(struct sock *sk, struct tcp_authopt_info *info)
> +{
> +	struct hlist_node *n;
> +	struct tcp_authopt_key_info *key;
> +
> +	hlist_for_each_entry_safe(key, n, &info->head, node)
> +		tcp_authopt_key_del(sk, key);
> +	kfree_rcu(info, rcu);
> +}
> +
> +/* free everything and clear tcp_sock.authopt_info to NULL */
> +void tcp_authopt_clear(struct sock *sk)
> +{
> +	struct tcp_authopt_info *info;
> +
> +	info = rcu_dereference_protected(tcp_sk(sk)->authopt_info, lockdep_sock_is_held(sk));
> +	if (info) {
> +		__tcp_authopt_info_free(sk, info);
> +		tcp_sk(sk)->authopt_info = NULL;
> +	}
> +}
> +
> +int tcp_set_authopt_key(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	struct tcp_authopt_key opt;
> +	struct tcp_authopt_info *info;
> +	struct tcp_authopt_key_info *key_info;
> +	u8 traffic_key_len, maclen;
> +
> +	if (optlen < sizeof(opt))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&opt, optval, sizeof(opt)))
> +		return -EFAULT;
> +
> +	if (opt.keylen > TCP_AUTHOPT_MAXKEYLEN)
> +		return -EINVAL;
> +
> +	if (opt.local_id == 0)
> +		return -EINVAL;
> +
> +	/* must set authopt before setting keys */
> +	info = rcu_dereference_protected(tcp_sk(sk)->authopt_info, lockdep_sock_is_held(sk));
> +	if (!info)
> +		return -EINVAL;
> +
> +	if (opt.flags & TCP_AUTHOPT_KEY_DEL) {
> +		key_info = __tcp_authopt_key_info_lookup(sk, info, opt.local_id);
> +		if (!key_info)
> +			return -ENOENT;
> +		tcp_authopt_key_del(sk, key_info);
> +		return 0;
> +	}
> +
> +	/* check the algorithm */
> +	if (opt.alg == TCP_AUTHOPT_ALG_HMAC_SHA_1_96) {
> +		traffic_key_len = 20;
> +		maclen = 12;
> +	} else if (opt.alg == TCP_AUTHOPT_ALG_AES_128_CMAC_96) {
> +		traffic_key_len = 16;
> +		maclen = 12;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* If an old value exists for same local_id it is deleted */
> +	key_info = __tcp_authopt_key_info_lookup(sk, info, opt.local_id);
> +	if (key_info)
> +		tcp_authopt_key_del(sk, key_info);
> +	key_info = sock_kmalloc(sk, sizeof(*key_info), GFP_KERNEL | __GFP_ZERO);
> +	if (!key_info)
> +		return -ENOMEM;
> +	key_info->local_id = opt.local_id;
> +	key_info->flags = opt.flags & TCP_AUTHOPT_KEY_EXCLUDE_OPTS;
> +	key_info->send_id = opt.send_id;
> +	key_info->recv_id = opt.recv_id;
> +	key_info->alg = opt.alg;
> +	key_info->keylen = opt.keylen;
> +	memcpy(key_info->key, opt.key, opt.keylen);
> +	key_info->maclen = maclen;
> +	key_info->traffic_key_len = traffic_key_len;
> +	hlist_add_head_rcu(&key_info->node, &info->head);
> +
> +	return 0;
> +}

I have looked up to here and will continue tomorrow.

BTW, this patch seems a bit large to me, so splitting it will make it
easier to read.

Kuniyuki
