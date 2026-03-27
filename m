Return-Path: <linux-crypto+bounces-22513-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOMUJTW6xmnoNwUAu9opvQ
	(envelope-from <linux-crypto+bounces-22513-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 18:11:17 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA94348182
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 18:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2253330ABD5B
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8982371886;
	Fri, 27 Mar 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CUSlZjbC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C0372B37
	for <linux-crypto@vger.kernel.org>; Fri, 27 Mar 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631039; cv=none; b=XU2D9G86POL02Ws3aOpiGOUorc1a0mIvsjdgcrGPE3dxRrEH/8xfRis18ASO5M0KWZeVFDZS+Y4LThcB4LPLDOEfm9ggTlhFGW9LAkkuZ5dDvfZPLdSYPY3W6zPAXvCvK39v7yeoILK+d/oa3ITYcxBf/wb7zSJ1WsDkdeDkFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631039; c=relaxed/simple;
	bh=+tauNC4op/1f1UOR6hc+/glfE3S89C+fm7BIK2HXnBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpSMknzREl34XvCYCEQ1Sautd2dXYXejGfwN3OVDotwVM1XUlZd3dsVUBVnmf0dXRgwzPp0LKJN4ZGTymsRYcN3wfgx904e39gRWaQGh9va70srCKxHlTYHJMj2oRUVVjZrRWIy4UZVD3H7kglO59222gP2pu535OuMJn47q0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CUSlZjbC; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22480 invoked from network); 27 Mar 2026 18:03:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774631028; bh=1pNHOOxkrInwAKVW1kychxWbDV24cN7qwurpLcenHAg=;
          h=Subject:To:Cc:From;
          b=CUSlZjbCPiBqxQiLpBHw2huIXCvZEblim9cHHLDW+olL1wSW0EUM03fCaDQlC6vhk
           seIVRHg+yHBBx2eMqOJ6c7+Pch2dzdgrBTC9ocHOIbZKhlSuPDgCnZSZL4NvF+PFi/
           fjvpWRR2REI1HKvnOMYMINOEr+SGCX8kfdpV1qk+pdXpgjXu4Fh61Ucaiag14ywOWD
           Brxok7210QSDFuM/h4YlftujO9V3uT+07kKpAk9bkgp2YlV/C8qMLe/djDe8NJ5r4U
           wL0UqmcrxEIc5BXmYe/rgGZBWanSraSi+HnYQz4f+sI0rajVL1vLDEWZ19OE6UK1xx
           XE4xilcro5gzA==
Received: from 83.5.169.164.ipv4.supernova.orange.pl (HELO [192.168.1.21]) (olek2@wp.pl@[83.5.169.164])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <herbert@gondor.apana.org.au>; 27 Mar 2026 18:03:48 +0100
Message-ID: <c2a3dc2e-8d4a-4a59-ac5a-ca22be705488@wp.pl>
Date: Fri, 27 Mar 2026 18:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] crypto: testmgr - Add test vectors for
 authenc(hmac(md5),cbc(aes))
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-crypto@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260303184916.69132-1-olek2@wp.pl>
 <abToanZh-mkEjmJ-@gondor.apana.org.au>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <abToanZh-mkEjmJ-@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: c35bd8ae87df3f160010f467442666b9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [YFOn]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22513-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:email,wp.pl:mid]
X-Rspamd-Queue-Id: ECA94348182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Herbert,

On 14/03/2026 05:47, Herbert Xu wrote:
> On Tue, Mar 03, 2026 at 07:48:44PM +0100, Aleksander Jan Bajkowski wrote:
>> Test vectors were generated starting from existing CBC(AES) test vectors
>> (RFC3602, NIST SP800-38A) and adding HMAC(MD5) computed with Python
>> script. Then, the results were double-checked on Mediatek MT7981 (safexcel)
>> and NXP P2020 (talitos). Both platforms pass self-tests.
>>
>> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
>> ---
>> v4:
>> - rename aes-generic -> aes-lib
>> v3:
>> - correct sha384 -> md5 in description
>> v2:
>> - rebase and resolve conflicts
>> ---
>>   crypto/testmgr.c |   7 ++
>>   crypto/testmgr.h | 255 +++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 262 insertions(+)
> The previous patch has already been applied.  Please redo this
> as an incremental patch.

Checked the crypto tree, and this patch still isn't applied. I've sent 
multiple test vectors, and you're probably referring to a another patch. 
Should I send it again, or will you accept it as is?

By the way, that's the last one. As of now, all my routers have the 
missing vectors added :)

Regards, Aleksander


