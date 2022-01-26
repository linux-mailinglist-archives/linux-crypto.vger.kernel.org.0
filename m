Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8149CC19
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Jan 2022 15:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiAZOQq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Jan 2022 09:16:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44526 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiAZOQq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Jan 2022 09:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC5EB81E6F;
        Wed, 26 Jan 2022 14:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A25C340E3;
        Wed, 26 Jan 2022 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643206603;
        bh=4PEx14OefEZmGP/tmNgG+5aOKJHhW+/95bP3E2bnR5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJX65/te+B1L5vBsMewrHxKJyp1fqOV1u6wUklfzHxnQcFJUmYzhi/U2/vC54oKPs
         Me2lRye9bmNmjYTYliOLQV1zkQwehbZqdE9T9rSFkMQrNfb82K3/nqgB4KOp4UIG9d
         90DEk2586o8SsiO8dMCTzFfy2hFZA6bNX1b7xcUpyB3Es9GCp5+WPKOjTsDxL4M7h0
         s+pXMY4E3k7BwjmHma5eLCyzBfy9g5jPNQCUKO1FIbEtgY/sX4ITwMAxHHe12DyhWU
         Lpr3mnCJzb6kiPmTzVhnLK7NK3rw6V06qmAsUOPdPLA4krwgViH3GqesAPVzQbwkqO
         ZMupLCqoGt+kA==
Date:   Wed, 26 Jan 2022 16:16:23 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KEYS: x509: clearly distinguish between key and
 signature algorithms
Message-ID: <YfFXty7oOW5AonZb@iki.fi>
References: <20220119005436.119072-1-ebiggers@kernel.org>
 <20220119005436.119072-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119005436.119072-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 18, 2022 at 04:54:33PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> An X.509 certificate has two, potentially different public key
> algorithms: the one used by the certificate's key, and the one that was
> used to sign the certificate.  Some of the naming made it unclear which
> algorithm was meant.  Rename things appropriately:
> 
>     - x509_note_pkey_algo() => x509_note_sig_algo()
>     - algo_oid => sig_algo
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/x509.asn1          |  2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c | 32 +++++++++++++----------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/x509.asn1 b/crypto/asymmetric_keys/x509.asn1
> index 5c9f4e4a52310..92d59c32f96a8 100644
> --- a/crypto/asymmetric_keys/x509.asn1
> +++ b/crypto/asymmetric_keys/x509.asn1
> @@ -7,7 +7,7 @@ Certificate ::= SEQUENCE {
>  TBSCertificate ::= SEQUENCE {
>  	version           [ 0 ]	Version DEFAULT,
>  	serialNumber		CertificateSerialNumber ({ x509_note_serial }),
> -	signature		AlgorithmIdentifier ({ x509_note_pkey_algo }),
> +	signature		AlgorithmIdentifier ({ x509_note_sig_algo }),
>  	issuer			Name ({ x509_note_issuer }),
>  	validity		Validity,
>  	subject			Name ({ x509_note_subject }),
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 083405eb80c32..aec2396a7f7e1 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -24,9 +24,9 @@ struct x509_parse_context {
>  	size_t		key_size;		/* Size of key data */
>  	const void	*params;		/* Key parameters */
>  	size_t		params_size;		/* Size of key parameters */
> -	enum OID	key_algo;		/* Public key algorithm */
> +	enum OID	key_algo;		/* Algorithm used by the cert's key */
>  	enum OID	last_oid;		/* Last OID encountered */
> -	enum OID	algo_oid;		/* Algorithm OID */
> +	enum OID	sig_algo;		/* Algorithm used to sign the cert */
>  	unsigned char	nr_mpi;			/* Number of MPIs stored */
>  	u8		o_size;			/* Size of organizationName (O) */
>  	u8		cn_size;		/* Size of commonName (CN) */
> @@ -187,11 +187,10 @@ int x509_note_tbs_certificate(void *context, size_t hdrlen,
>  }
>  
>  /*
> - * Record the public key algorithm
> + * Record the algorithm that was used to sign this certificate.
>   */
> -int x509_note_pkey_algo(void *context, size_t hdrlen,
> -			unsigned char tag,
> -			const void *value, size_t vlen)
> +int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
> +		       const void *value, size_t vlen)
>  {
>  	struct x509_parse_context *ctx = context;
>  
> @@ -263,22 +262,22 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>  rsa_pkcs1:
>  	ctx->cert->sig->pkey_algo = "rsa";
>  	ctx->cert->sig->encoding = "pkcs1";
> -	ctx->algo_oid = ctx->last_oid;
> +	ctx->sig_algo = ctx->last_oid;
>  	return 0;
>  ecrdsa:
>  	ctx->cert->sig->pkey_algo = "ecrdsa";
>  	ctx->cert->sig->encoding = "raw";
> -	ctx->algo_oid = ctx->last_oid;
> +	ctx->sig_algo = ctx->last_oid;
>  	return 0;
>  sm2:
>  	ctx->cert->sig->pkey_algo = "sm2";
>  	ctx->cert->sig->encoding = "raw";
> -	ctx->algo_oid = ctx->last_oid;
> +	ctx->sig_algo = ctx->last_oid;
>  	return 0;
>  ecdsa:
>  	ctx->cert->sig->pkey_algo = "ecdsa";
>  	ctx->cert->sig->encoding = "x962";
> -	ctx->algo_oid = ctx->last_oid;
> +	ctx->sig_algo = ctx->last_oid;
>  	return 0;
>  }
>  
> @@ -291,11 +290,16 @@ int x509_note_signature(void *context, size_t hdrlen,
>  {
>  	struct x509_parse_context *ctx = context;
>  
> -	pr_debug("Signature type: %u size %zu\n", ctx->last_oid, vlen);
> +	pr_debug("Signature: alg=%u, size=%zu\n", ctx->last_oid, vlen);
>  
> -	if (ctx->last_oid != ctx->algo_oid) {
> -		pr_warn("Got cert with pkey (%u) and sig (%u) algorithm OIDs\n",
> -			ctx->algo_oid, ctx->last_oid);
> +	/*
> +	 * In X.509 certificates, the signature's algorithm is stored in two
> +	 * places: inside the TBSCertificate (the data that is signed), and
> +	 * alongside the signature.  These *must* match.
> +	 */
> +	if (ctx->last_oid != ctx->sig_algo) {
> +		pr_warn("signatureAlgorithm (%u) differs from tbsCertificate.signature (%u)\n",
> +			ctx->last_oid, ctx->sig_algo);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.34.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


/Jarkko
