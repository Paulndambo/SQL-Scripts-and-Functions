from apps.policies.models import Cycle, CycleStatusUpdates
import csv

def get_cancellation_list():
    cycles = Cycle.objects.filter(status='cancelled')
    print(cycles.count())
    #for cycle in cycles:
    #    cst = CycleStatusUpdates.objects.filter(cycle=cycle).latest("created")
    #    csts.append(cst.id)
    #print(len(csts))