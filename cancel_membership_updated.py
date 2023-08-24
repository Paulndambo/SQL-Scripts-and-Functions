def lapse_memberships():
    lapses = CancellationData.objects.all()

    for x in lapses:
        profile = ''
        if x.identification_method == 1:
            profile = Profile.objects.filter(id_number=x.identification_number).first()
        else:
            profile = Profile.objects.filter(passport_number=x.identification_number).first()

        if profile:
            membership = Membership.objects.filter(user=profile.user, scheme_group__pricing_group=get_pricing_plan(product)).first()
        if membership:
            cycle = Cycle.objects.filter(membership=membership).first()

            if cycle.status.lower() == "cancelled".lower():
                ## Log error report
                create_upload_error_log("Cancel", data, "cancelled_member", "Membership is already cancelled")

            else:
                cycle.status = "cancelled"
                cycle.save()

                CycleStatusUpdates.objects.create(
                    cycle=cycle,
                    previous_status="active",
                    next_status="cancelled",
                )

                CancellationNotification.objects.create(
                    policy=policy,
                    membership=membership,
                    email=membership.user.email,
                    mobile_number=profile.phone if profile.phone else profile.phone1,
                    notification_send=False,
                    policy_type="Group Scheme",
                    product=membership.scheme_group.pricing_group    
                )

        