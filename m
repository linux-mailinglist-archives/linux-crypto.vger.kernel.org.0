Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110B841CE3A
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Sep 2021 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbhI2VfC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 Sep 2021 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhI2VfC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 Sep 2021 17:35:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7FC061767
        for <linux-crypto@vger.kernel.org>; Wed, 29 Sep 2021 14:33:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so16242686lfu.2
        for <linux-crypto@vger.kernel.org>; Wed, 29 Sep 2021 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Db6sq5b/zoZ7Ckw0MsC3401ruyMn9GYqskLXtTDWY1U=;
        b=YdD0IEPWfMh3400z3lZO/rXLrtkQdQQzT6E5rNYfIx/1o1+K+Sfq8GEGo2o9PK3SVa
         6ODe3xygpnglVPfJK7LbN0wS38dxtDpecAWVPMXikimHtBJ6+YhqM650fFsJ4+zlyuU6
         9LdRaIjGBfhkgktm2Zm1XsMhVMBMCExPjVbSkA2RfiB4vFvaKHbIN2Yfy4WmYZIsuTPO
         t/CXw8yCyg+AjLGDWtdP023ISv/OzvDjJW0JDYwn17qtSF78jWMSGOVPzGSQJetv5aIO
         KGaP4EhF/uc/epmRf4no4+MwopbE3RlK0tnZh6R9UZgx5fpSGZ5Lpd1gjB1ahUYuUFKz
         ayaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Db6sq5b/zoZ7Ckw0MsC3401ruyMn9GYqskLXtTDWY1U=;
        b=0+fj2+dtrTgpVkiXSwBh0Zpp/HL30GmOJnNuvX34o2t4G7E7lXgZlXNYKUictcTkvr
         TZdHO+omZrNiHDo/8PMzWpyOzMbDbBcLwbM//5zr0rYXCJOHqzePZ/pClz/fL4yuXKJE
         1w9uuFQE0fUfFAV4VFoa2d2rTj4IDmQ26376+5MCCp9yUIgGzPJxJ3ktTd0cjJ3pC+ss
         te3g4QgEC+bT4bpzZQ3ZoPhC5aNLXNFymgUB3J5w8P7VTC7tPvLVwFnB4tCBUUA/kLJS
         tYXNO9DfHKEPuxxm1LqdAhVcy/Od26GYVXKZdzuOvwFjl+PyGEI9g04+zHvaZv0EHpIm
         sTww==
X-Gm-Message-State: AOAM531Tppt2S7K9ovfJkQ20b+af2Opcn1YcZClgCgXPvH0zkQUXaRvp
        RKh6rrdL7jQ7fXONgDV9Fcff8dDzLIrS53f9nfQAtA==
X-Google-Smtp-Source: ABdhPJzhCoDwFynfAd1TEDbYhSvAM8Evozq3qMnqQMfeskozU8Jk++cf4vW2wdpliQwTatEGUSw7odWrZm7W1h6plVw=
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr2269532ljp.282.1632951198592;
 Wed, 29 Sep 2021 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210820155918.7518-1-brijesh.singh@amd.com> <20210820155918.7518-43-brijesh.singh@amd.com>
In-Reply-To: <20210820155918.7518-43-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 29 Sep 2021 15:33:07 -0600
Message-ID: <CAMkAt6rzFvscq46CKYrhcf3d8VCGzy3tiM_SycnDRr9gVwXOSA@mail.gmail.com>
Subject: Re: [PATCH Part2 v5 42/45] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 20, 2021 at 10:01 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> Version 2 of GHCB specification added the support for two SNP Guest
> Request Message NAE events. The events allows for an SEV-SNP guest to
> make request to the SEV-SNP firmware through hypervisor using the
> SNP_GUEST_REQUEST API define in the SEV-SNP firmware specification.
>
> The SNP_EXT_GUEST_REQUEST is similar to SNP_GUEST_REQUEST with the
> difference of an additional certificate blob that can be passed through
> the SNP_SET_CONFIG ioctl defined in the CCP driver. The CCP driver
> provides snp_guest_ext_guest_request() that is used by the KVM to get
> both the report and certificate data at once.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 197 +++++++++++++++++++++++++++++++++++++++--
>  arch/x86/kvm/svm/svm.h |   2 +
>  2 files changed, 193 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 712e8907bc39..81ccad412e55 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -19,6 +19,7 @@
>  #include <linux/trace_events.h>
>  #include <linux/sev.h>
>  #include <linux/ksm.h>
> +#include <linux/sev-guest.h>
>  #include <asm/fpu/internal.h>
>
>  #include <asm/pkru.h>
> @@ -338,6 +339,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
>
>                 init_srcu_struct(&sev->psc_srcu);
>                 ret = sev_snp_init(&argp->error);
> +               mutex_init(&sev->guest_req_lock);
>         } else {
>                 ret = sev_platform_init(&argp->error);
>         }
> @@ -1602,23 +1604,39 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>
>  static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  {
> +       void *context = NULL, *certs_data = NULL, *resp_page = NULL;
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>         struct sev_data_snp_gctx_create data = {};
> -       void *context;
>         int rc;
>
> +       /* Allocate memory used for the certs data in SNP guest request */
> +       certs_data = kmalloc(SEV_FW_BLOB_MAX_SIZE, GFP_KERNEL_ACCOUNT);
> +       if (!certs_data)
> +               return NULL;
> +
>         /* Allocate memory for context page */
>         context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
>         if (!context)
> -               return NULL;
> +               goto e_free;
> +
> +       /* Allocate a firmware buffer used during the guest command handling. */
> +       resp_page = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
> +       if (!resp_page)
> +               goto e_free;
>
>         data.gctx_paddr = __psp_pa(context);
>         rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
> -       if (rc) {
> -               snp_free_firmware_page(context);
> -               return NULL;
> -       }
> +       if (rc)
> +               goto e_free;
> +
> +       sev->snp_certs_data = certs_data;
>
>         return context;
> +
> +e_free:
> +       snp_free_firmware_page(context);
> +       kfree(certs_data);
> +       return NULL;
>  }
>
>  static int snp_bind_asid(struct kvm *kvm, int *error)
> @@ -2248,6 +2266,8 @@ static int snp_decommission_context(struct kvm *kvm)
>         snp_free_firmware_page(sev->snp_context);
>         sev->snp_context = NULL;
>
> +       kfree(sev->snp_certs_data);
> +
>         return 0;
>  }
>
> @@ -2746,6 +2766,8 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm, u64 *exit_code)
>         case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>         case SVM_VMGEXIT_HV_FEATURES:
>         case SVM_VMGEXIT_PSC:
> +       case SVM_VMGEXIT_GUEST_REQUEST:
> +       case SVM_VMGEXIT_EXT_GUEST_REQUEST:
>                 break;
>         default:
>                 goto vmgexit_err;
> @@ -3161,6 +3183,155 @@ static unsigned long snp_handle_page_state_change(struct vcpu_svm *svm)
>         return rc ? map_to_psc_vmgexit_code(rc) : 0;
>  }
>
> +static unsigned long snp_setup_guest_buf(struct vcpu_svm *svm,
> +                                        struct sev_data_snp_guest_request *data,
> +                                        gpa_t req_gpa, gpa_t resp_gpa)
> +{
> +       struct kvm_vcpu *vcpu = &svm->vcpu;
> +       struct kvm *kvm = vcpu->kvm;
> +       kvm_pfn_t req_pfn, resp_pfn;
> +       struct kvm_sev_info *sev;
> +
> +       sev = &to_kvm_svm(kvm)->sev_info;
> +
> +       if (!IS_ALIGNED(req_gpa, PAGE_SIZE) || !IS_ALIGNED(resp_gpa, PAGE_SIZE))
> +               return SEV_RET_INVALID_PARAM;
> +
> +       req_pfn = gfn_to_pfn(kvm, gpa_to_gfn(req_gpa));
> +       if (is_error_noslot_pfn(req_pfn))
> +               return SEV_RET_INVALID_ADDRESS;
> +
> +       resp_pfn = gfn_to_pfn(kvm, gpa_to_gfn(resp_gpa));
> +       if (is_error_noslot_pfn(resp_pfn))
> +               return SEV_RET_INVALID_ADDRESS;
> +
> +       if (rmp_make_private(resp_pfn, 0, PG_LEVEL_4K, 0, true))
> +               return SEV_RET_INVALID_ADDRESS;
> +
> +       data->gctx_paddr = __psp_pa(sev->snp_context);
> +       data->req_paddr = __sme_set(req_pfn << PAGE_SHIFT);
> +       data->res_paddr = __sme_set(resp_pfn << PAGE_SHIFT);
> +
> +       return 0;
> +}
> +
> +static void snp_cleanup_guest_buf(struct sev_data_snp_guest_request *data, unsigned long *rc)
> +{
> +       u64 pfn = __sme_clr(data->res_paddr) >> PAGE_SHIFT;
> +       int ret;
> +
> +       ret = snp_page_reclaim(pfn);
> +       if (ret)
> +               *rc = SEV_RET_INVALID_ADDRESS;
> +
> +       ret = rmp_make_shared(pfn, PG_LEVEL_4K);
> +       if (ret)
> +               *rc = SEV_RET_INVALID_ADDRESS;
> +}
> +
> +static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
> +{
> +       struct sev_data_snp_guest_request data = {0};
> +       struct kvm_vcpu *vcpu = &svm->vcpu;
> +       struct kvm *kvm = vcpu->kvm;
> +       struct kvm_sev_info *sev;
> +       unsigned long rc;
> +       int err;
> +
> +       if (!sev_snp_guest(vcpu->kvm)) {
> +               rc = SEV_RET_INVALID_GUEST;
> +               goto e_fail;
> +       }
> +
> +       sev = &to_kvm_svm(kvm)->sev_info;
> +
> +       mutex_lock(&sev->guest_req_lock);
> +
> +       rc = snp_setup_guest_buf(svm, &data, req_gpa, resp_gpa);
> +       if (rc)
> +               goto unlock;
> +
> +       rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &err);
> +       if (rc)
> +               /* use the firmware error code */
> +               rc = err;
> +
> +       snp_cleanup_guest_buf(&data, &rc);
> +
> +unlock:
> +       mutex_unlock(&sev->guest_req_lock);
> +
> +e_fail:
> +       svm_set_ghcb_sw_exit_info_2(vcpu, rc);
> +}
> +
> +static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
> +{
> +       struct sev_data_snp_guest_request req = {0};
> +       struct kvm_vcpu *vcpu = &svm->vcpu;
> +       struct kvm *kvm = vcpu->kvm;
> +       unsigned long data_npages;
> +       struct kvm_sev_info *sev;
> +       unsigned long rc, err;
> +       u64 data_gpa;
> +
> +       if (!sev_snp_guest(vcpu->kvm)) {
> +               rc = SEV_RET_INVALID_GUEST;
> +               goto e_fail;
> +       }
> +
> +       sev = &to_kvm_svm(kvm)->sev_info;
> +
> +       data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
> +       data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
> +
> +       if (!IS_ALIGNED(data_gpa, PAGE_SIZE)) {
> +               rc = SEV_RET_INVALID_ADDRESS;
> +               goto e_fail;
> +       }
> +
> +       /* Verify that requested blob will fit in certificate buffer */
> +       if ((data_npages << PAGE_SHIFT) > SEV_FW_BLOB_MAX_SIZE) {
> +               rc = SEV_RET_INVALID_PARAM;
> +               goto e_fail;
> +       }
> +
> +       mutex_lock(&sev->guest_req_lock);
> +
> +       rc = snp_setup_guest_buf(svm, &req, req_gpa, resp_gpa);
> +       if (rc)
> +               goto unlock;
> +
> +       rc = snp_guest_ext_guest_request(&req, (unsigned long)sev->snp_certs_data,
> +                                        &data_npages, &err);
> +       if (rc) {
> +               /*
> +                * If buffer length is small then return the expected
> +                * length in rbx.
> +                */
> +               if (err == SNP_GUEST_REQ_INVALID_LEN)
> +                       vcpu->arch.regs[VCPU_REGS_RBX] = data_npages;
> +
> +               /* pass the firmware error code */
> +               rc = err;
> +               goto cleanup;
> +       }
> +
> +       /* Copy the certificate blob in the guest memory */
> +       if (data_npages &&
> +           kvm_write_guest(kvm, data_gpa, sev->snp_certs_data, data_npages << PAGE_SHIFT))
> +               rc = SEV_RET_INVALID_ADDRESS;
> +
> +cleanup:
> +       snp_cleanup_guest_buf(&req, &rc);
> +
> +unlock:
> +       mutex_unlock(&sev->guest_req_lock);
> +
> +e_fail:
> +       svm_set_ghcb_sw_exit_info_2(vcpu, rc);
> +}
> +
>  static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  {
>         struct vmcb_control_area *control = &svm->vmcb->control;
> @@ -3404,6 +3575,20 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>                 svm_set_ghcb_sw_exit_info_2(vcpu, rc);
>                 break;
>         }
> +       case SVM_VMGEXIT_GUEST_REQUEST: {
> +               snp_handle_guest_request(svm, control->exit_info_1, control->exit_info_2);
> +
> +               ret = 1;
> +               break;
> +       }
> +       case SVM_VMGEXIT_EXT_GUEST_REQUEST: {
> +               snp_handle_ext_guest_request(svm,
> +                                            control->exit_info_1,
> +                                            control->exit_info_2);
> +
> +               ret = 1;
> +               break;
> +       }

Don't we need some sort of rate limiting here? Since the PSP is a
shared resource that the host needs access to as well as other guests
it seems a little dangerous to let the guest spam this interface.

>         case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>                 vcpu_unimpl(vcpu,
>                             "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 280072995306..71fe46a778f3 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -92,6 +92,8 @@ struct kvm_sev_info {
>         u64 snp_init_flags;
>         void *snp_context;      /* SNP guest context page */
>         struct srcu_struct psc_srcu;
> +       void *snp_certs_data;
> +       struct mutex guest_req_lock;
>  };
>
>  struct kvm_svm {
> --
> 2.17.1
>
