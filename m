Return-Path: <linux-crypto+bounces-24602-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIgiDdGtFWqzXwcAu9opvQ
	(envelope-from <linux-crypto+bounces-24602-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 26 May 2026 16:27:29 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8955D7770
	for <lists+linux-crypto@lfdr.de>; Tue, 26 May 2026 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39D5305C5B0
	for <lists+linux-crypto@lfdr.de>; Tue, 26 May 2026 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597C3D47C5;
	Tue, 26 May 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRt+GCB+"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978923B9935;
	Tue, 26 May 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805033; cv=none; b=CIs9CfE2hhW10VMCAj++zRP2QjLDBbc5sA1lG8o8Ib2XY/lssjbZKjapu+2vwv1PRBFXQIdhfRwFlhHCspVxZ+ls/cTsdJCIYG7MUFHLBZEmLC3WAI+H1HDokPh73zRlLcqgVrcLFptElWsI/7O/5MC5alxHXPu9OlTlGXKc1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805033; c=relaxed/simple;
	bh=uJFgd3/ogk0JmiL+ilZMgsxh3azG0zM/yHpAHSbKVLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6eQlltXVALhMEiKAF106K3luEXHslNmCSovfbpCIzN8j1VfexoUT0NPjCQAfYReUGbDr8THzJW4IL/V1J6q9zuhGtbKw81jm5imsOA35bRxWox8rRJsMumdD7Wx2Ok5mFny9ZYEXYvI8wzsjv1ls6qiSlwCVn9lxJ9dUqyRos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRt+GCB+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307DE1F000E9;
	Tue, 26 May 2026 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805032;
	bh=MOmfqqaPenCKNf8Jd7LGVJ2lCf/SJRwRNixbV+upgkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cRt+GCB+krSclmk2bvdkFkbTtWOZBrucfMRvXAHVRk6KLh8bnLT41k9GNxpGpTJMW
	 nBUUIrDjzji/xaDRhcaF/p5EErQ+uKcRK9+x1mrFkf3451MBDfJhlk1kPMZGUz3fsR
	 5nN53DLvus5UQdtU7ubxb06GgfpKwyqgsHX4Gj+Co+ifdEBHJ+HyXe24p8EmzfKaDh
	 TbSqYEJfzT00O5wW8C2gbm9wU/fl7TQrHeFd6N7lYF2tMMEp+s3+bOcvNVOpEJKDsZ
	 s92seROqPXr9tQV3w883KirwTJZMumj9e+iwhH8H89f1VugAN6aDTYk14/L4owwkOm
	 pIh3SiHVsPM+Q==
Date: Tue, 26 May 2026 15:17:07 +0100
From: Simon Horman <horms@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sock: add sock_kzalloc helper
Message-ID: <20260526141707.GL1506108@horms.kernel.org>
References: <20260427104129.309982-7-thorsten.blum@linux.dev>
 <ahBRCxCXbCq5LeCc@linux.dev>
 <ahVkZOxZtFes6Huf@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahVkZOxZtFes6Huf@gondor.apana.org.au>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-24602-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A8955D7770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:14:12PM +0800, Herbert Xu wrote:
> On Fri, May 22, 2026 at 02:50:19PM +0200, Thorsten Blum wrote:
> > Hi Herbert,
> > 
> > On Mon, Apr 27, 2026 at 12:41:30PM +0200, Thorsten Blum wrote:
> > > Add sock_kzalloc() helper - the sock equivalent to kzalloc().
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  include/net/sock.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index dccd3738c368..20bf406dff2d 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -1904,6 +1904,11 @@ void sock_kfree_s(struct sock *sk, void *mem, int size);
> > >  void sock_kzfree_s(struct sock *sk, void *mem, int size);
> > >  void sk_send_sigurg(struct sock *sk);
> > >  
> > > +static inline void *sock_kzalloc(struct sock *sk, int size, gfp_t priority)
> > > +{
> > > +	return sock_kmalloc(sk, size, priority | __GFP_ZERO);
> > > +}
> > > +
> > >  static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
> > >  {
> > >  	if (sk->sk_socket)
> > 
> > Can you take this series or should I resend this to net-next?
> 
> This patch needs an ack from the netdev maintainers.

In which case it probably needs to hit the netdev mailing list.

Thanks!

