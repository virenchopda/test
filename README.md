https://we.tl/t-y2PAAb5Ejf
casa_vertical_stepper:
  
          CasaVerticalStepperView(
            steps: [
              StepperStep(
                leading: const Icon(Icons.alarm),
                title: const Text('Application review'),
                view: const Column(
                  children: [NewWidget(), NewWidget()],
                ),
              ),
              StepperStep(
                leading: const Icon(Icons.alarm),
                visible: true,
                title: const Text('Application review'),
                view: const Column(
                  children: [
                    NewWidget(),
                    NewWidget(),
                    NewWidget(),
                    NewWidget(),
                    NewWidget(),
                    NewWidget(),
                  ],
                ),
              ),
            ],
            seperatorColor: Colors.red,
            showStepStatusWidget: false,
          ),
