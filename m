Return-Path: <linux-crypto+bounces-22067-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGIFNBvmuWmGPQIAu9opvQ
	(envelope-from <linux-crypto+bounces-22067-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 00:39:07 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEA2B4697
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 00:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4F49306A33A
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6087C3A782E;
	Tue, 17 Mar 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LUyho57F"
X-Original-To: linux-crypto@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB13A6EE5
	for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2026 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790722; cv=none; b=Lm5LxwQ5+CYY63O0oNDUO5jfufhiJC9uCgDxezMboziLUfojFYV6YRbqQE6/2HnSiVmNVtR5N+4KNVCVpL9lFK42N7vZXCfQqpwQpxnn5f3cwKTAxcKWPc0VSENdxTHqct8M1OocG3vBAJ6l/wmTJXXAdl2U0beaLm6ATMpS/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790722; c=relaxed/simple;
	bh=4N87Bkgtb0/aGn4yfIfymyt96koi5R0U5OOrJR6hay8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjv5ajwkpclBaQlkHRaW5IcrMmE/9JhjtqUUWH6+6+vNa1P+HqYo8lOzlyhZ169ykIRVbY4tR7Mzz8D9dT0Bbd5xziwL9BTpeOLgXZI6HySer5thqRzpjbEVfjnvGLZDt+ViTKokTem4s6OKxi4bXHWgYxAppMSxE/WC2UE6G1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=LUyho57F; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 2RDXwMEn9Kjfo2dyDwcF95; Tue, 17 Mar 2026 23:37:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2dyCwVKLjOs9R2dyCwiR25; Tue, 17 Mar 2026 23:37:04 +0000
X-Authority-Analysis: v=2.4 cv=HPPDFptv c=1 sm=1 tr=0 ts=69b9e5a1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=5vZi_tIctBNeQFYZvx8A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sDIz43D4MTuOarQG71u0YgFU0v977L2RxVybNkE8u+4=; b=LUyho57FaqByRfJY7uhMTFmu2S
	JtvA8JfGgXdiudXrchA0Ne/x/yclFIlMivpsXOevHirW5mjG/icJGiTomPM944RHVFmL96nWTmfbf
	0OHakIJxjnSoVrU4ROHvZ6m6HnQGzW17aca0t5fDloRsihkysr7Gh1NC13gYw5ykkbNKanAPYAwX3
	ZOl6Fnzyv+XdMK8DiJpToUkVbAaVXuNLyL90Cnml9v2GZJ+wQyyhgc3WQAUWQQT4YWd9f7CZoNVUx
	IbnseujQlUkv6pZY5YwQvJt7q72HYKUyhCFr0WLWS+v0YgGP388H1jJ7N+E3jkXuLlpo6PdDlVIkD
	xU9H6wJw==;
Received: from [177.238.16.13] (port=58304 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w2dy9-00000004JzL-3q9f;
	Tue, 17 Mar 2026 18:37:02 -0500
Message-ID: <bde61932-9c7e-4139-8d6a-8059c205a217@embeddedor.com>
Date: Tue, 17 Mar 2026 17:35:39 -0600
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: nx - annotate struct nx842_crypto_header with
 __counted_by
To: Thorsten Blum <thorsten.blum@linux.dev>, Haren Myneni <haren@us.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w2dy9-00000004JzL-3q9f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:58304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCa3XOhlUjk5RyFP9hHREO6R9C3EHOcica9DGMyp5b4a8HPdkYWRSJzj/8FRAj7kG8bNhwaviDilrm8DRb7GsfUuOWwN994DJCQPmDwbr/nnEG8c01j1
 JAuPBRam6Na89UoA36dcITBsbaBxx3FFo9bMcNJnfinv20qxbkkCcC7DvoM0A9UNOMIt9jJD+sDhUuZqQFO8JZDcK3LdiSzJMLc7MaV4AZY/IG/R/PKi847T
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22067-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,us.ibm.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,gondor.apana.org.au,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_X_ANTIABUSE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,linux-crypto@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,embeddedor.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 64CEA2B4697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/26 14:18, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/crypto/nx/nx-842.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
> index f5e2c82ba876..a04e85e9f78e 100644
> --- a/drivers/crypto/nx/nx-842.h
> +++ b/drivers/crypto/nx/nx-842.h
> @@ -164,7 +164,7 @@ struct nx842_crypto_header {
>   		__be16 ignore;		/* decompressed end bytes to ignore */
>   		u8 groups;		/* total groups in this header */
>   	);
> -	struct nx842_crypto_header_group group[];
> +	struct nx842_crypto_header_group group[] __counted_by(groups);
>   } __packed;
>   static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
>   	      "struct member likely outside of struct_group_tagged()");
> 


