Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9222598C05
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Aug 2022 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbiHRSvM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Aug 2022 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbiHRSvK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Aug 2022 14:51:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B1A4B0E;
        Thu, 18 Aug 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660848669; x=1692384669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mYadyzwA0ZoHMKNbg2eMtvWK2KsC51kLCrZfy90MEEM=;
  b=hohA4YYgGKxObxiknZnx7Aa9am/heukS4YdbGsDakhoIlxMZhW+8DseF
   ifeOILZrB7Ha37/qGsoASYhVa3GXV63b/UZzxmUHU9/2PCXPHDC3Ym72S
   6K8Bek/GpMUMBjuiDgkyhm5Ny+rV+FX/ZFhCJMrI7bDro+chbF1A54VRo
   VGl/D9oknFJTTwFvZyl6XogCRkDbLNDAmgYT1Nyj2/SscROOCFc6QCmUb
   X/iT8OWYlpNfieGRHZlNZwtjdKbZCE7pG+uHG/DKixVLxisX4NmcwGQsl
   qIzHYUrgPco/d6E10hDDQZZjuj9czOSn0jYEUDRtlpEY9lIj5uecmAkGc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279806175"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="279806175"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="783880247"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2022 11:51:02 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOkbe-0000Pg-0Q;
        Thu, 18 Aug 2022 18:51:02 +0000
Date:   Fri, 19 Aug 2022 02:50:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, netdev@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 08/31] net/tcp: Introduce TCP_AO setsockopt()s
Message-ID: <202208190223.JG4u6Nhm-lkp@intel.com>
References: <20220818170005.747015-9-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818170005.747015-9-dima@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on e34cfee65ec891a319ce79797dda18083af33a76]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/net-tcp-Add-TCP-AO-support/20220819-010628
base:   e34cfee65ec891a319ce79797dda18083af33a76
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220819/202208190223.JG4u6Nhm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/469bd71e5ea011f6ae5a1554b75157471448341d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Safonov/net-tcp-Add-TCP-AO-support/20220819-010628
        git checkout 469bd71e5ea011f6ae5a1554b75157471448341d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/ipv4/ net/ipv6/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv4/tcp_ao.c:19:20: warning: no previous prototype for 'tcp_ao_do_lookup_rcvid' [-Wmissing-prototypes]
      19 | struct tcp_ao_key *tcp_ao_do_lookup_rcvid(struct sock *sk, u8 keyid)
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   net/ipv4/tcp_ao.c:37:20: warning: no previous prototype for 'tcp_ao_do_lookup_sndid' [-Wmissing-prototypes]
      37 | struct tcp_ao_key *tcp_ao_do_lookup_sndid(const struct sock *sk, u8 keyid)
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   net/ipv4/tcp_ao.c: In function '__tcp_ao_key_cmp':
   net/ipv4/tcp_ao.c:88:46: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      88 |                 if (ipv6_addr_any(&key->addr.a6) || ipv6_addr_any(&addr->a6))
         |                                              ^~
         |                                              a4
   net/ipv4/tcp_ao.c:88:74: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      88 |                 if (ipv6_addr_any(&key->addr.a6) || ipv6_addr_any(&addr->a6))
         |                                                                          ^~
         |                                                                          a4
   net/ipv4/tcp_ao.c:90:50: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      90 |                 if (ipv6_prefix_equal(&key->addr.a6, &addr->a6, prefixlen))
         |                                                  ^~
         |                                                  a4
   net/ipv4/tcp_ao.c:90:61: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      90 |                 if (ipv6_prefix_equal(&key->addr.a6, &addr->a6, prefixlen))
         |                                                             ^~
         |                                                             a4
   net/ipv4/tcp_ao.c:92:42: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      92 |                 return memcmp(&key->addr.a6, &addr->a6, prefixlen);
         |                                          ^~
         |                                          a4
   net/ipv4/tcp_ao.c:92:53: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
      92 |                 return memcmp(&key->addr.a6, &addr->a6, prefixlen);
         |                                                     ^~
         |                                                     a4
   net/ipv4/tcp_ao.c: At top level:
>> net/ipv4/tcp_ao.c:96:5: warning: no previous prototype for 'tcp_ao_key_cmp' [-Wmissing-prototypes]
      96 | int tcp_ao_key_cmp(const struct tcp_ao_key *key,
         |     ^~~~~~~~~~~~~~
   net/ipv4/tcp_ao.c: In function 'tcp_ao_key_cmp':
   net/ipv4/tcp_ao.c:100:61: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
     100 |         if (family == AF_INET6 && ipv6_addr_v4mapped(&addr->a6)) {
         |                                                             ^~
         |                                                             a4
   net/ipv4/tcp_ao.c:101:38: error: 'const union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
     101 |                 __be32 addr4 = addr->a6.s6_addr32[3];
         |                                      ^~
         |                                      a4
   net/ipv4/tcp_ao.c: At top level:
   net/ipv4/tcp_ao.c:109:20: warning: no previous prototype for 'tcp_ao_do_lookup' [-Wmissing-prototypes]
     109 | struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
         |                    ^~~~~~~~~~~~~~~~
>> net/ipv4/tcp_ao.c:145:6: warning: no previous prototype for 'tcp_ao_link_mkt' [-Wmissing-prototypes]
     145 | void tcp_ao_link_mkt(struct tcp_ao_info *ao, struct tcp_ao_key *mkt)
         |      ^~~~~~~~~~~~~~~
   In file included from include/linux/tcp.h:19,
                    from net/ipv4/tcp_ao.c:13:
   net/ipv4/tcp_ao.c: In function 'tcp_ao_verify_ipv6':
   include/net/sock.h:385:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     385 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   net/ipv4/tcp_ao.c:292:41: note: in expansion of macro 'sk_v6_daddr'
     292 |                 if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
         |                                         ^~~~~~~~~~~
   include/net/sock.h:385:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     385 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   net/ipv4/tcp_ao.c:293:45: note: in expansion of macro 'sk_v6_daddr'
     293 |                         __be32 daddr4 = sk->sk_v6_daddr.s6_addr32[3];
         |                                             ^~~~~~~~~~~
   include/net/sock.h:385:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     385 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   net/ipv4/tcp_ao.c:295:54: note: in expansion of macro 'sk_v6_daddr'
     295 |                         if (!ipv6_addr_v4mapped(&sk->sk_v6_daddr))
         |                                                      ^~~~~~~~~~~
   include/net/sock.h:385:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     385 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   net/ipv4/tcp_ao.c:316:41: note: in expansion of macro 'sk_v6_daddr'
     316 |                 if (!ipv6_addr_any(&sk->sk_v6_daddr) &&
         |                                         ^~~~~~~~~~~
   include/net/sock.h:385:45: error: 'struct sock_common' has no member named 'skc_v6_daddr'; did you mean 'skc_daddr'?
     385 | #define sk_v6_daddr             __sk_common.skc_v6_daddr
         |                                             ^~~~~~~~~~~~
   net/ipv4/tcp_ao.c:317:45: note: in expansion of macro 'sk_v6_daddr'
     317 |                     !ipv6_prefix_equal(&sk->sk_v6_daddr, addr, prefix))
         |                                             ^~~~~~~~~~~
   net/ipv4/tcp_ao.c: In function 'tcp_ao_mkt_overlap_v6':
   net/ipv4/tcp_ao.c:531:39: error: 'union tcp_ao_addr' has no member named 'a6'; did you mean 'a4'?
     531 |                 key_addr = &key->addr.a6;
         |                                       ^~
         |                                       a4
   net/ipv4/tcp_ao.c: In function '__tcp_ao_key_cmp':
   net/ipv4/tcp_ao.c:94:1: error: control reaches end of non-void function [-Werror=return-type]
      94 | }
         | ^
   cc1: some warnings being treated as errors


vim +/tcp_ao_do_lookup_rcvid +19 net/ipv4/tcp_ao.c

    18	
  > 19	struct tcp_ao_key *tcp_ao_do_lookup_rcvid(struct sock *sk, u8 keyid)
    20	{
    21		struct tcp_sock *tp = tcp_sk(sk);
    22		struct tcp_ao_key *key;
    23		struct tcp_ao_info *ao;
    24	
    25		ao = rcu_dereference_check(tp->ao_info, lockdep_sock_is_held(sk));
    26	
    27		if (!ao)
    28			return NULL;
    29	
    30		hlist_for_each_entry_rcu(key, &ao->head, node) {
    31			if (key->rcvid == keyid)
    32				return key;
    33		}
    34		return NULL;
    35	}
    36	
    37	struct tcp_ao_key *tcp_ao_do_lookup_sndid(const struct sock *sk, u8 keyid)
    38	{
    39		struct tcp_ao_key *key;
    40		struct tcp_ao_info *ao;
    41	
    42		ao = rcu_dereference_check(tcp_sk(sk)->ao_info,
    43					   lockdep_sock_is_held(sk));
    44		if (!ao)
    45			return NULL;
    46	
    47		hlist_for_each_entry_rcu(key, &ao->head, node) {
    48			if (key->sndid == keyid)
    49				return key;
    50		}
    51		return NULL;
    52	}
    53	
    54	static inline int ipv4_prefix_cmp(const struct in_addr *addr1,
    55					  const struct in_addr *addr2,
    56					  unsigned int prefixlen)
    57	{
    58		__be32 mask = inet_make_mask(prefixlen);
    59	
    60		if ((addr1->s_addr & mask) == (addr2->s_addr & mask))
    61			return 0;
    62		return ((addr1->s_addr & mask) > (addr2->s_addr & mask)) ? 1 : -1;
    63	}
    64	
    65	static int __tcp_ao_key_cmp(const struct tcp_ao_key *key,
    66				    const union tcp_ao_addr *addr, u8 prefixlen,
    67				    int family, int sndid, int rcvid, u16 port)
    68	{
    69		if (sndid >= 0 && key->sndid != sndid)
    70			return (key->sndid > sndid) ? 1 : -1;
    71		if (rcvid >= 0 && key->rcvid != rcvid)
    72			return (key->rcvid > rcvid) ? 1 : -1;
    73		if (port != 0 && key->port != 0 && port != key->port)
    74			return (key->port > port) ? 1 : -1;
    75	
    76		if (family == AF_UNSPEC)
    77			return 0;
    78		if (key->family != family)
    79			return (key->family > family) ? 1 : -1;
    80	
    81		if (family == AF_INET) {
    82			if (key->addr.a4.s_addr == INADDR_ANY)
    83				return 0;
    84			if (addr->a4.s_addr == INADDR_ANY)
    85				return 0;
    86			return ipv4_prefix_cmp(&key->addr.a4, &addr->a4, prefixlen);
    87		} else {
    88			if (ipv6_addr_any(&key->addr.a6) || ipv6_addr_any(&addr->a6))
    89				return 0;
    90			if (ipv6_prefix_equal(&key->addr.a6, &addr->a6, prefixlen))
    91				return 0;
  > 92			return memcmp(&key->addr.a6, &addr->a6, prefixlen);
    93		}
    94	}
    95	
  > 96	int tcp_ao_key_cmp(const struct tcp_ao_key *key,
    97			   const union tcp_ao_addr *addr, u8 prefixlen,
    98			   int family, int sndid, int rcvid, u16 port)
    99	{
   100		if (family == AF_INET6 && ipv6_addr_v4mapped(&addr->a6)) {
 > 101			__be32 addr4 = addr->a6.s6_addr32[3];
   102	
   103			return __tcp_ao_key_cmp(key, (union tcp_ao_addr *)&addr4,
   104						prefixlen, AF_INET, sndid, rcvid, port);
   105		}
   106		return __tcp_ao_key_cmp(key, addr, prefixlen, family, sndid, rcvid, port);
   107	}
   108	
   109	struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
   110					    const union tcp_ao_addr *addr,
   111					    int family, int sndid, int rcvid, u16 port)
   112	{
   113		struct tcp_ao_key *key;
   114		struct tcp_ao_info *ao;
   115	
   116		ao = rcu_dereference_check(tcp_sk(sk)->ao_info,
   117					   lockdep_sock_is_held(sk));
   118		if (!ao)
   119			return NULL;
   120	
   121		hlist_for_each_entry_rcu(key, &ao->head, node) {
   122			if (!tcp_ao_key_cmp(key, addr, key->prefixlen,
   123					    family, sndid, rcvid, port))
   124				return key;
   125		}
   126		return NULL;
   127	}
   128	EXPORT_SYMBOL(tcp_ao_do_lookup);
   129	
   130	static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags,
   131			struct tcp_ao_info *cloned_from)
   132	{
   133		struct tcp_ao_info *ao;
   134	
   135		ao = kzalloc(sizeof(*ao), flags);
   136		if (!ao)
   137			return NULL;
   138		INIT_HLIST_HEAD(&ao->head);
   139	
   140		if (cloned_from)
   141			ao->ao_flags = cloned_from->ao_flags;
   142		return ao;
   143	}
   144	
 > 145	void tcp_ao_link_mkt(struct tcp_ao_info *ao, struct tcp_ao_key *mkt)
   146	{
   147		hlist_add_head_rcu(&mkt->node, &ao->head);
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
